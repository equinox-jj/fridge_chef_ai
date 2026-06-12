import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/ingredient_entity.dart';

part 'ingredient_review_cubit.freezed.dart';
part 'ingredient_review_state.dart';

/// Holds the editable ingredient list during review.
///
/// Edits (quantity tweaks, removals, manual additions) stay in memory only —
/// the persisted rows are never touched (PRD §4.2.4). The list feeds recipe
/// generation once the user is happy with it.
class IngredientReviewCubit extends Cubit<IngredientReviewState> {
  IngredientReviewCubit({
    required List<IngredientEntity> initialItems,
    this.scanId,
  }) : super(IngredientReviewState(items: List<IngredientEntity>.unmodifiable(initialItems)));

  /// The scan these ingredients came from, threaded through to recipe
  /// generation so a saved recipe can be linked back to it. Null when the
  /// review was opened without a backing scan.
  final String? scanId;

  /// Smallest amount we let a stepper reach; below 1 the user should remove the
  /// item instead.
  static const int _minQuantity = 1;
  static const int _maxQuantity = 9999;

  void incrementQuantity(int index) => _stepQuantity(index, 1);

  void decrementQuantity(int index) => _stepQuantity(index, -1);

  void _stepQuantity(int index, int delta) {
    if (index < 0 || index >= state.items.length) return;
    final IngredientEntity current = state.items[index];
    final int currentQty = int.tryParse(current.quantity?.trim() ?? '') ?? _minQuantity;
    final int next = (currentQty + delta).clamp(_minQuantity, _maxQuantity);
    if (next == currentQty) return;

    final List<IngredientEntity> items = List<IngredientEntity>.of(state.items);
    items[index] = current.copyWith(quantity: '$next');
    emit(state.copyWith(items: items));
  }

  void remove(int index) {
    if (index < 0 || index >= state.items.length) return;
    final List<IngredientEntity> items = List<IngredientEntity>.of(state.items)..removeAt(index);
    emit(state.copyWith(items: items));
  }

  /// Appends a manually-entered ingredient (the "Gemini missed something" flow).
  void addIngredient({
    required String name,
    required String quantity,
    required String unit,
    required String category,
  }) {
    final IngredientEntity item = IngredientEntity(
      name: name.trim(),
      quantity: quantity.trim(),
      unit: unit.trim(),
      category: category,
    );
    emit(state.copyWith(items: <IngredientEntity>[...state.items, item]));
  }
}

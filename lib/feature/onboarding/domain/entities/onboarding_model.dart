// ignore_for_file: public_member_api_docs, sort_constructors_first

class OnboardingModel {
  String name;
  int montlyIncome;
  int monthlyExpense;
  OnboardingModel({
    this.name = "",
    this.montlyIncome = 0,
    this.monthlyExpense = 0,
  });

  OnboardingModel copyWith({
    String? name,
    int? montlyIncome,
    int? monthlyExpense,
  }) {
    return OnboardingModel(
      name: name ?? this.name,
      montlyIncome: montlyIncome ?? this.montlyIncome,
      monthlyExpense: monthlyExpense ?? this.monthlyExpense,
    );
  }
}

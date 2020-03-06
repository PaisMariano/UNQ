data NExp = Var Variable | NCte Int | Add NExp NExp | Sub NExp NExp | Mul NExp NExp | Div NExp NExp | Mod NExp NExp

type Variable = String
module TotalOrder

(* definition of a total order *)
type relation 'a = 'a -> 'a -> Tot bool

type isReflexive (#a:Type) (rel:relation a) = forall x. rel x x
type isAntiSymmetric (#a:eqtype) (rel:relation a) = forall x y. rel x y /\ rel y x ==> x = y
type isTransitive (#a:Type) (rel:relation a) = forall x y z. rel x y /\ rel y z ==> rel x z
type isTotalRelation (#a:Type) (rel:relation a) = forall x y. rel x y \/ rel y x

type isPreOrder (#a:Type) (rel:relation a) = isReflexive rel /\ isTransitive rel
type isPartialOrder (#a:eqtype) (rel:relation a) = isPreOrder rel /\ isAntiSymmetric rel
type isTotalOrder (#a:eqtype) (rel:relation a) = isPartialOrder rel /\ isTotalRelation rel

type totalOrder (#a:eqtype) = rel:(relation a){isTotalOrder #a rel}

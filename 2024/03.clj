(ns adventofcode.2024.03)

(defn parse-expr [expr]
  (let [e (rest expr)]
    (case (first e)
      "mul" (cons :mul (map parse-long (rest e)))
      "do" '(:do)
      "don't" '(:dont))))

(defn parse-file [file]
  (map parse-expr (re-seq #"(mul|do|don't)\((\d+)?(?:,(\d+))*\)" file)))

(defn mul? [expr] (= :mul (first expr)))
(defn do? [expr] (= :do (first expr)))
(defn dont? [expr] (= :dont (first expr)))

(defn calc [exprs]
  (when (not= exprs '())
    (concat (->> exprs (take-while (complement dont?)))
            (->> exprs (drop-while (complement do?)) (rest) (calc)))))

(def in (parse-file (slurp *in*)))

(defn f1 []
  (->> in
       (filter mul?)
       (map #(apply * (rest %)))
       (apply +)))

(defn f2 []
  (->> (calc in)
       (filter mul?)
       (map #(apply * (rest %)))
       (apply +)))

(println (f2))

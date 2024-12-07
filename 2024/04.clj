(ns adventofcode.2024.04
  (:require [clojure.string :as str]
            [clojure.set :as set]))

;; regex matcher that returns the positions instead of the matches
;; because clojure doesn't even have this stupid simple shit
;; adapted from stackoverflow https://stackoverflow.com/a/21192299
(defn re-pos [pattern string]
  (let [m (re-matcher pattern string)]
    ((fn step []
       (when (. m find)
         (cons (. m start)
               (lazy-seq (step))))))))

(defn find-xmas [in]
  (apply + (map #(count (re-seq #"(?=XMAS|SAMX)" %)) in)))

(defn find-mas [in]
  (->> in
       (map-indexed (fn [i line] (map #(list i (inc %)) (re-pos #"(?=MAS|SAM)" line))))
       (apply concat)))

(defn to-mas-coords [w [line x]]
  (let [a (max 0 (- line (dec w)))]
    (list (+ x a) (- line x a))))

(defn flip-mas-coord [h [x y]] (list (- h y 1) x))

(defn find-mas-diag [n in]
  (set (map #(to-mas-coords n %) (find-mas in))))

(defn transpose [x] (apply map str x))

(defn diag [n [line & lines]]
  (when (>= n 0)
    (str (nth line n "")
         (diag (dec n) lines))))

(defn rotate-45 [lines]
  (for [i (range (->> lines count (* 2) dec))]
    (diag i lines)))

(def in (str/split-lines (slurp *in*)))

(defn f1 []
  (+ (find-xmas in)
     (find-xmas (transpose in))
     (find-xmas (rotate-45 in))
     (find-xmas (rotate-45 (transpose (reverse in))))))

(defn f2 []
  (count (set/intersection
          (->> (rotate-45 in) (find-mas-diag (count in)))
          (->> (rotate-45 (transpose (reverse in)))
               (find-mas-diag (count in))
               (map #(flip-mas-coord (count in) %))
               set))))

(println (f2))

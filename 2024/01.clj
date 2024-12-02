(ns adventofcode.2024.01
  (:require [clojure.string :as str]))

;; also works as unzip (lisp magic? maybe this should be called transpose)
(defn zip [x]
  (apply map list x))

(defn parse-line [line]
  (map parse-long (str/split line #"\s+")))

(defn parse-file [file]
  (map parse-line (str/split-lines file)))

(defn similarity-score [n in]
  (->> in (filter #{n}) (count) (* n)))

(def in (parse-file (slurp *in*)))

(defn f1 []
  (let [pairs (zip (map sort (zip in)))]
    (->> pairs
         (map #(abs (apply - %1)))
         (apply +))))

(defn f2 []
  (let [[l1 l2] (zip in)]
    (->> l1
         (map #(similarity-score %1 l2))
         (apply +))))

;; (println (f1))
(println (f2))

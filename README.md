# **Jak działać ma aplikacja?**
Po **logowaniu** zostajemy przekierowani do **sklepu**. Jeżeli konto ma prawa admina, to można ze sklepu przejść do **panelu administracyjnego**.
----------
Zauważcie, że nie uwzględniłem rejestracji. Użytkownicy już będą w bazie. Rejestrację ewentualnie możemy dodać później.
----------
1. Logowanie jak logowanie.
2. Wyniki ze sklepu można **filtrować**. Na podstawie filtrów, wyświetla się **N ofert** (obrazek + parametry auta + przycisk *buy*).
3. Panel administracyjny to **miejsce do popisu dla naszych zapytań**, tu wykorzystać możemy te bardziej złożone od prostego selecta - admin może chcieć znać ostatnią aktywność na stronie lub top 3 użytkowników, którzy wydali najwięcej (bo ludzie u nas, oczywiście, będą kupować te samochody jak bułki w sklepie).
----------
**TODO list**:

- dockerfile dla bazy danych i dla aplikacji,
- jinja htmls (login.html, view.html, admin-view.html),
- funkcje do komunikacji z bazą danych,
- flask routes // czyli spięcie frontendu z bazą danych.
----------
Jakich funkcji do komunikacją z bazą danych potrzebujemy? Nie wiem.

Przykłady:
- def **validate_user**(username, password) → select exists(select 1 from account where …)
- def **fetch_cars_list**(p, q, filter = None) → jeżeli filter jest pusty, to zwykły select na tabelę z samochodami; jeżeli filter nie jest pusty, to trzeba skonstruować odpowiednie zapytanie z warunkami. Pobieramy elementy o indeksach [p,q).



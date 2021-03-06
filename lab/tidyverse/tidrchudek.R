
#ZADANIA

#1. Kt�ra Marka wyst�puje najcz�ciej w zbiorze danych auta2012?

auta %>%
  group_by(Marka) %>%
  count() %>%
  arrange(desc(n)) %>%
  head(1)

# 2. Spo�r�d aut marki Toyota, kt�ry model wyst�puje najcz�ciej.


auta %>%
  filter(Marka == "Toyota") %>%
  group_by(Model) %>%
  summarise( n = n()) %>%
  arrange( desc(n)) %>%
  head(1)

# 3. Sprawd� ile jest aut z silnikiem diesla wyprodukowanych w 2007 roku?

auta %>%
  filter(Rodzaj.paliwa == "olej napedowy (diesel)", Rok.produkcji == 2007) %>%
  count()

# 4. Jakiego koloru auta maj� najmniejszy medianowy przebieg?


auta2012 %>%
  group_by(Kolor) %>%
  summarise( przeb.med = median(Przebieg.w.km, na.rm = TRUE) ) %>%
  arrange(przeb.med) %>%
  head(1)

# 5. Gdy ograniczy� si� tylko do aut wyprodukowanych w 2007, kt�ra Marka wyst�puje najcz�ciej w zbiorze danych auta2012?

auta2012 %>%
  filter(Rok.produkcji == 2007) %>%
  group_by( Marka) %>%
  count() %>%
  arrange(desc(n)) %>%
  head(1)

# 6. Spo�r�d aut marki Toyota, kt�ry model najbardziej straci� na cenie pomi�dzy rokiem produkcji 2007 a 2008.

auta2012 %>%
  filter(Marka == "Toyota", Rok.produkcji %in% c(2007, 2008)) %>%
  select(Model,Cena.w.PLN.w.PLN, Rok.produkcji) %>%
  group_by(Model, Rok.produkcji) %>%
  summarise( src = mean(Cena.w.PLN.w.PLN)) %>%
  spread(., Rok.produkcji, src) %>%
  mutate( rozn = `2007` - `2008`) %>%
  arrange( desc(rozn)) %>%
  head(1)


# 7. Spo�r�d aut z silnikiem diesla wyprodukowanych w 2007 roku kt�ra marka jest najdro�sza?


auta2012 %>%
  filter(Rodzaj.paliwa == "olej napedowy (diesel)", Rok.produkcji ==2007) %>%
  select(Marka, Cena.w.PLN) %>%
  group_by(Marka) %>%
  summarise( sr.Cena.w.PLN = mean(Cena.w.PLN)) %>%
  arrange(sr.Cena.w.PLN) %>%
  head(1)

# 8. Ile jest aut z klimatyzacj�?
head(auta2012)

auta2012 %>%
  mutate( czy.klim = grepl("klimatyzacja", Wyposazenie.dodatkowe, ignore.case = TRUE) ) %>%
  summarise( sum(czy.klim))

# 9. Gdy ograniczy� si� tylko do aut z silnikiem ponad 100 KM, kt�ra Marka wyst�puje najcz�ciej w zbiorze danych auta2012?

auta2012 %>%
  filter( KM > 100)  %>%
  group_by(Marka) %>%
  count() %>%
  arrange(desc(n)) %>%
  head(1)

# 10. Spo�r�d aut marki Toyota, kt�ry model ma najwi�ksz� r�nic� cen gdy por�wna� silniki benzynowe a diesel?

# wroc
auta2012 %>%
  filter( Marka == "Toyota", Rodzaj.paliwa == "benzyna" | Rodzaj.paliwa ==  'olej napedowy (diesel)') %>%
  select(Model, Cena.w.PLN, Rodzaj.paliwa) %>%
  group_by( Model, Rodzaj.paliwa) %>%
  summarise( sr = mean(Cena.w.PLN)) %>%
  spread(., Rodzaj.paliwa, sr ) %>%
  mutate( rozn =  abs(benzyna - `olej napedowy (diesel)`)) %>%
  arrange(-rozn) %>%
  head(1)

# w pln 
auta2012 %>%
  filter( Marka == "Toyota", Rodzaj.paliwa %in% c( "benzyna" , 'olej napedowy (diesel)')) %>%
  select(Model, Cena.w.PLN.w.PLN, Rodzaj.paliwa) %>%
  group_by( Model, Rodzaj.paliwa) %>%
  summarise( sr = mean(Cena.w.PLN.w.PLN)) %>%
  spread(., Rodzaj.paliwa, sr ) %>%
  mutate( rozn =  abs(benzyna - `olej napedowy (diesel)`)) %>%
  arrange(-rozn) %>%
  head(1)


# 11. Spo�r�d aut z silnikiem diesla wyprodukowanych w 2007 roku kt�ra marka jest najta�sza?

auta2012 %>%
  filter( Rok.produkcji ==2007, Rodzaj.paliwa == "olej napedowy (diesel)" ) %>%
  group_by( Marka) %>%
  summarise( sr.cen = mean(Cena.w.PLN)) %>%
  arrange(desc(sr.cen)) %>%
  head(1)

# 12. W jakiej marce klimatyzacja jest najcz�ciej obecna?

auta2012 %>%
  mutate( czy.klim = grepl("klimatyzacja", Wyposazenie.dodatkowe, ignore.case = TRUE) ) %>%
  filter( czy.klim == 1) %>%
  group_by(Marka) %>%
  count() %>%
  arrange( desc(n)) %>%
  head(1)

# 13. Gdy ograniczy� si� tylko do aut o cenie ponad 50 000 PLN, kt�ra Marka wyst�puje najcz�ciej w zbiorze danych auta2012?

auta2012 %>%
  filter(Cena.w.PLN.w.PLN >50000)%>%
  group_by(Marka) %>%
  count() %>%
  arrange( desc(n)) %>%
  head(1)

# 14. Spo�r�d aut marki Toyota, kt�ry model ma najwi�kszy medianowy przebieg?

auta2012 %>%
  filter( Marka == "Toyota") %>%
  group_by( Model) %>%
  summarise( med = median(Przebieg.w.km, na.rm = TRUE)) %>%
  arrange( desc(med)) %>%
  head(1)

#  15. Spo�r�d aut z silnikiem diesla wyprodukowanych w 2007 roku kt�ry model jest najdro�szy?


auta2012 %>%
  filter( Rodzaj.paliwa == "olej napedowy (diesel)", Rok.produkcji == 2007) %>%
  group_by(Model) %>%
  summarise( cen = mean(Cena.w.PLN)) %>%
  arrange( desc(cen)) %>%
  head(1)

# 16. W jakim modelu klimatyzacja jest najcz�ciej obecna?

auta2012 %>%
  mutate( czy.klim = grepl("klimatyzacja", Wyposazenie.dodatkowe, ignore.case = TRUE) ) %>%
  filter( czy.klim == 1) %>%
  group_by(Model) %>%
  count() %>%
  arrange( desc(n)) %>%
  head(1)

# 17. Gdy ograniczy� si� tylko do aut o przebiegu poni�ej 50 000 km o silniku diesla, kt�ra Marka wyst�puje najcz�ciej w zbiorze danych auta2012?

auta2012 %>%
  filter( Rodzaj.paliwa == "olej napedowy (diesel)", Przebieg.w.km < 50000) %>%
  group_by(Marka) %>%
  count() %>%
  arrange( desc(n)) %>%
  head(1)

# 18. Spo�r�d aut marki Toyota wyprodukowanych w 2007 roku, kt�ry model jest �rednio najdro�szy?


auta2012 %>%
  filter( Marka == "Toyota", Rok.produkcji == 2007) %>%
  select(Model, Cena.w.PLN) %>%
  group_by(Model) %>%
  summarise( src = mean(Cena.w.PLN)) %>%
  arrange( desc(src)) %>%
  head(1)

# 19. Spo�r�d aut z silnikiem diesla wyprodukowanych w 2007 roku kt�ry model jest najta�szy?

auta2012 %>%
  filter( Rodzaj.paliwa == "olej napedowy (diesel)", Rok.produkcji == 2007) %>% 
  group_by(Model) %>%
  summarise(sr = mean(Cena.w.PLN))%>%
  arrange( sr) %>%
  head(1)

# 20.  Jakiego koloru auta maj� najwi�kszy medianowy przebieg?

auta2012 %>%
  group_by(Kolor) %>%
  summarise( przeb.med = median(Przebieg.w.km, na.rm = TRUE) ) %>%
  arrange(desc(przeb.med)) %>%
  head(1)






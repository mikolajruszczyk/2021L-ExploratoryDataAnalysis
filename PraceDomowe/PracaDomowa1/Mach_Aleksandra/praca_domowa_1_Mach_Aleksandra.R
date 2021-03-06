install.packages("PogromcyDanych")
library(PogromcyDanych)
View(auta2012)

## 1. Sprawd� ile jest aut z silnikiem diesla wyprodukowanych w 2007 roku?
auta2012 %>% 
  filter(Rodzaj.paliwa == "olej napedowy (diesel)" & Rok.produkcji == 2007) %>% 
  nrow()
## Odp: 11621


## 2. Jakiego koloru auta maj� najmniejszy medianowy przebieg?
auta2012 %>% 
  group_by(Kolor) %>% 
  summarise(med_przeb = median(Przebieg.w.km, na.rm = TRUE)) %>% 
  arrange(med_przeb)
## Odp: bialy-metallic
    

## 3. Gdy ograniczy� si� tylko do aut wyprodukowanych w 2007, kt�ra Marka wyst�puje najcz�ciej w zbiorze danych auta2012?
auta2012 %>% 
  filter(Rok.produkcji ==2007) %>% 
  group_by(Marka) %>% 
  count() %>% 
  arrange(-n)
## Odp: Volkswgagen  

  
## 4. Spo�r�d aut z silnikiem diesla wyprodukowanych w 2007 roku kt�ra marka jest najta�sza?
auta2012 %>% 
  filter(Rodzaj.paliwa == "olej napedowy (diesel)" & Rok.produkcji == 2007) %>% 
  group_by(Marka) %>% 
  summarise(srednia_cena = mean(Cena.w.PLN)) %>% 
  arrange(srednia_cena)
## Odp: Aixam


## 5. Spo�r�d aut marki Toyota, kt�ry model najbardziej straci� na cenie pomi�dzy rokiem produkcji 2007 a 2008.
auta2012 %>% 
  filter(Marka == "Toyota" & Rok.produkcji == 2007) %>% 
  group_by(Model) %>% 
  summarise(sr_2007 = mean(Cena.w.PLN)) %>% 
  select(sr_2007, Model) -> srednia_cena_2007

auta2012 %>% 
  filter(Marka == "Toyota" & Rok.produkcji == 2008) %>% 
  group_by(Model) %>% 
  summarise(sr_2008 = mean(Cena.w.PLN)) %>% 
  select(sr_2008, Model) -> srednia_cena_2008

srednia_cena_2007 %>% 
  inner_join(srednia_cena_2008, by = "Model") %>% 
  mutate(roznica = (sr_2007-sr_2008)) %>% 
  arrange(-roznica)

## Odp: Hiace


## 6. W jakiej marce klimatyzacja jest najcz�ciej obecna?
auta2012 %>%
  filter("klimatyzacja" %in% Wyposazenie.dodatkowe) %>% 
  group_by(Marka) %>% 
  count() %>% 
  arrange(-n)
## Odp: Volkswagen


## 7. Gdy ograniczy� si� tylko do aut z silnikiem ponad 100 KM, kt�ra Marka wyst�puje najcz�ciej w zbiorze danych auta2012?
auta2012 %>% 
  filter(KM > 100) %>% 
  group_by(Marka) %>% 
  count() %>% 
  arrange(-n) 
## Odp: Volkswagen


## 8. Gdy ograniczy� si� tylko do aut o przebiegu poni�ej 50 000 km o silniku diesla, kt�ra Marka wyst�puje najcz�ciej w zbiorze danych auta2012?
auta2012 %>% 
  filter(Przebieg.w.km < 50000 & Rodzaj.paliwa == "olej napedowy (diesel)") %>% 
  group_by(Marka) %>% 
  count() %>% 
  arrange(-n)
## Odp: BMW


## 9. Spo�r�d aut marki Toyota wyprodukowanych w 2007 roku, kt�ry model jest �rednio najdro�szy?
auta2012 %>% 
  filter(Marka == "Toyota" & Rok.produkcji == 2007) %>%
  group_by(Model) %>% 
  summarise(srednia_cena = mean(Cena.w.PLN, na.rm = TRUE)) %>% 
  arrange(-srednia_cena)
## Odp: Land Cruiser


## 10. Spo�r�d aut marki Toyota, kt�ry model ma najwi�ksz� r�nic� cen gdy por�wna� silniki benzynowe a diesel?
auta2012 %>% 
  filter(Marka == "Toyota" & Rodzaj.paliwa == "olej napedowy (diesel)") %>% 
  group_by(Model) %>% 
  summarise(sr_diesel = mean(Cena.w.PLN, na.rm = TRUE)) -> diesel

auta2012 %>% 
  filter(Marka == "Toyota" & Rodzaj.paliwa == "benzyna") %>% 
  group_by(Model) %>% 
  summarise(sr_benzyna = mean(Cena.w.PLN, na.rm = TRUE)) -> benzyna

diesel %>% 
  inner_join(benzyna, by = "Model") %>% 
  mutate(roznica = abs(sr_diesel - sr_benzyna)) %>% 
  arrange(-roznica)

## Odp: Camry



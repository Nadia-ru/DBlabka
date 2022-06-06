-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3307
-- Время создания: Июн 06 2022 г., 17:26
-- Версия сервера: 8.0.19
-- Версия PHP: 8.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `travel_agency`
--

-- --------------------------------------------------------

--
-- Структура таблицы `accommodation`
--

CREATE TABLE `accommodation` (
  `id` int NOT NULL,
  `title` varchar(100) NOT NULL,
  `stars` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `arrival_date` date NOT NULL,
  `eviction_date` date NOT NULL,
  `id_city` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `city`
--

CREATE TABLE `city` (
  `id` int NOT NULL,
  `country` varchar(50) NOT NULL,
  `city_title` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `city`
--

INSERT INTO `city` (`id`, `country`, `city_title`) VALUES
(1, 'Франция', 'Париж'),
(2, 'Россия', 'Москва'),
(3, 'Fed', 'XEP');

-- --------------------------------------------------------

--
-- Структура таблицы `customer`
--

CREATE TABLE `customer` (
  `id` int NOT NULL,
  `first_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `last_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `middle_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `date_of_birth` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `excursion`
--

CREATE TABLE `excursion` (
  `id` int NOT NULL,
  `location` varchar(255) NOT NULL,
  `id_city` int NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `excursion`
--

INSERT INTO `excursion` (`id`, `location`, `id_city`, `price`) VALUES
(1, 'Всё равно твоя мамка', 1, '13.99');

-- --------------------------------------------------------

--
-- Структура таблицы `travel`
--

CREATE TABLE `travel` (
  `id` int NOT NULL,
  `id_city_from` int NOT NULL,
  `id_city_where` int NOT NULL,
  `type` varchar(20) NOT NULL,
  `departure_date` datetime NOT NULL,
  `arrival_date` datetime NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `voucher`
--

CREATE TABLE `voucher` (
  `id` int NOT NULL,
  `id_customer` int NOT NULL,
  `paid` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `voucher_accommodation`
--

CREATE TABLE `voucher_accommodation` (
  `id` int NOT NULL,
  `id_voucher` int NOT NULL,
  `id_accomadation` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `voucher_excursion`
--

CREATE TABLE `voucher_excursion` (
  `id` int NOT NULL,
  `id_voucher` int NOT NULL,
  `id_excursion` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `voucher_travel`
--

CREATE TABLE `voucher_travel` (
  `id` int NOT NULL,
  `id_voucher` int NOT NULL,
  `id_travel` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `accommodation`
--
ALTER TABLE `accommodation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_city` (`id_city`);

--
-- Индексы таблицы `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `excursion`
--
ALTER TABLE `excursion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_city` (`id_city`);

--
-- Индексы таблицы `travel`
--
ALTER TABLE `travel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_city_from` (`id_city_from`),
  ADD KEY `id_city_where` (`id_city_where`);

--
-- Индексы таблицы `voucher`
--
ALTER TABLE `voucher`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_customer` (`id_customer`);

--
-- Индексы таблицы `voucher_accommodation`
--
ALTER TABLE `voucher_accommodation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_voucher` (`id_voucher`),
  ADD KEY `id_accomadation` (`id_accomadation`);

--
-- Индексы таблицы `voucher_excursion`
--
ALTER TABLE `voucher_excursion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_voucher` (`id_voucher`),
  ADD KEY `id_excursion` (`id_excursion`);

--
-- Индексы таблицы `voucher_travel`
--
ALTER TABLE `voucher_travel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_voucher` (`id_voucher`),
  ADD KEY `id_travel` (`id_travel`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `accommodation`
--
ALTER TABLE `accommodation`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `city`
--
ALTER TABLE `city`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `excursion`
--
ALTER TABLE `excursion`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `travel`
--
ALTER TABLE `travel`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `voucher`
--
ALTER TABLE `voucher`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `voucher_accommodation`
--
ALTER TABLE `voucher_accommodation`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `voucher_excursion`
--
ALTER TABLE `voucher_excursion`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `voucher_travel`
--
ALTER TABLE `voucher_travel`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `accommodation`
--
ALTER TABLE `accommodation`
  ADD CONSTRAINT `accommodation_ibfk_1` FOREIGN KEY (`id_city`) REFERENCES `city` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `excursion`
--
ALTER TABLE `excursion`
  ADD CONSTRAINT `excursion_ibfk_1` FOREIGN KEY (`id_city`) REFERENCES `city` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `travel`
--
ALTER TABLE `travel`
  ADD CONSTRAINT `travel_ibfk_1` FOREIGN KEY (`id_city_from`) REFERENCES `city` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `travel_ibfk_2` FOREIGN KEY (`id_city_where`) REFERENCES `city` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `voucher`
--
ALTER TABLE `voucher`
  ADD CONSTRAINT `voucher_ibfk_1` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `voucher_accommodation`
--
ALTER TABLE `voucher_accommodation`
  ADD CONSTRAINT `voucher_accommodation_ibfk_1` FOREIGN KEY (`id_voucher`) REFERENCES `voucher` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `voucher_accommodation_ibfk_2` FOREIGN KEY (`id_accomadation`) REFERENCES `accommodation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `voucher_excursion`
--
ALTER TABLE `voucher_excursion`
  ADD CONSTRAINT `voucher_excursion_ibfk_1` FOREIGN KEY (`id_voucher`) REFERENCES `voucher` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `voucher_excursion_ibfk_2` FOREIGN KEY (`id_excursion`) REFERENCES `excursion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `voucher_travel`
--
ALTER TABLE `voucher_travel`
  ADD CONSTRAINT `voucher_travel_ibfk_1` FOREIGN KEY (`id_voucher`) REFERENCES `voucher` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `voucher_travel_ibfk_2` FOREIGN KEY (`id_travel`) REFERENCES `travel` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

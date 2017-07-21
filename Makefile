# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agundry <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2016/11/28 09:03:11 by agundry           #+#    #+#              #
#    Updated: 2017/07/21 12:24:53 by agundry          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME =	libftprintf.a

CC =	gcc

CFLAGS =	-Wall -Werror -Wextra

INC = ft_printf.h
IPATH = includes
HEADERS = $(INC:%.h=$(IPATH)/%.h)
CFLAGS += $(addprefix -I,$(IPATH))

SPATH = src
vpath %.c $(SPATH)
SRC =	ft_printf.c ft_printf_core.c \
		conv_c.c conv_d.c conv_prc.c conv_s.c \
		conv_uo.c conv_wc.c conv_wcs.c conv_x.c \
		parsing.c ft_xtoa_base.c int_formatting.c str_formatting.c utf8.c

OPATH = obj
OBJ =	$(addprefix $(OPATH)/,$(SRC:%.c=%.o))

LPATH = libft
LIBFT = $(LPATH)/libft.a
CFLAGS += -I $(LPATH)/include

all : $(NAME)

$(LIBFT):
	$(MAKE) -C $(LPATH) all

$(NAME) : $(OBJ) $(LIBFT)
	libtool -v -static -o $@ $^

$(OBJ): $(HEADERS) | $(OPATH)
$(OBJ): $(OPATH)/%.o: %.c
	$(CC) $(CFlAGS) -c $< -o $@

$(OPATH):
	@-mkdir -p $@
clean :	
	rm -f $(OBJ)

fclean : clean
	rm -f $(NAME)

re : fclean all
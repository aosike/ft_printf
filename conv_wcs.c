/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   conv_wcs.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: agundry <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2017/08/01 16:55:15 by agundry           #+#    #+#             */
/*   Updated: 2017/10/31 11:47:39 by agundry          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libftprintf.h"

int	conv_wcs(t_buf *buf, t_format *fmt, va_list vl)
{
	char	*arg;
	wchar_t	*wcs;
	size_t	arglenmax;
	size_t	wlen;

	if ((wcs = va_arg(vl, wchar_t*)) == NULL)
		wcs = L"(null)";
	arglenmax = ft_wcslen(wcs) * sizeof(wchar_t) + 1;
	if ((arg = (char*)malloc(arglenmax)) == 0)
		exit_printf(4);
	wlen = (fmt->prec < 0) ? arglenmax : fmt->prec;
	if ((wlen = ft_wcstombs(arg, wcs, wlen, fmt)) == (size_t)-1)
		return (-1);
	if (fmt->f_minus == 0)
		str_formatting(buf, fmt, wlen);
	ft_buf_add(buf, arg, wlen);
	if (fmt->min_width > 0 && fmt->f_minus == 1)
		str_formatting(buf, fmt, wlen);
	free(arg);
	return (1);
}

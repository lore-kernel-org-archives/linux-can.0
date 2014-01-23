From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: can-utils: install in /usr/bin instead of /usr/local/bin ??
Date: Thu, 23 Jan 2014 15:07:47 +0100
Message-ID: <CAGm1_ksyL6SEWLfBjigig2iW5Tdc8eGXZez6brypvZxVOtWMFQ@mail.gmail.com>
References: <52E12015.7000201@hartkopp.net> <52E12081.4010301@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f51.google.com ([209.85.214.51]:64286 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753845AbaAWOIJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Jan 2014 09:08:09 -0500
Received: by mail-bk0-f51.google.com with SMTP id w10so373435bkz.24
        for <linux-can@vger.kernel.org>; Thu, 23 Jan 2014 06:08:07 -0800 (PST)
In-Reply-To: <52E12081.4010301@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Alexander GQ Gerasiov <gq@debian.org>, Nikita <nebaruzdin@lvk.cs.msu.su>

On Thu, Jan 23, 2014 at 3:00 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 01/23/2014 02:58 PM, Oliver Hartkopp wrote:
>> Hi Marc,
>>
>> when can-utils are now intended to be packaged for Debian:
>>
>> Does it make sense to move the installation directory to /usr/bin instead of
>> the current /usr/local/bin target??
>
> No, Uwe will probably use ./configure --prefix=/usr

CC Alexander and Nikita.

Yegor

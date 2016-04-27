From: =?UTF-8?Q?Florian_Vall=C3=A9e?= <fvallee@eukrea.fr>
Subject: Re: [PATCH] can: m_can: fix bitrate setup on latest silicon
Date: Wed, 27 Apr 2016 18:47:08 +0200
Message-ID: <CADgCO2_O0EAiV3+HZiobSrM6kaV-QjUHKCtcLjWkjXVZcOXHyQ@mail.gmail.com>
References: <1461678379-28257-1-git-send-email-fvallee@eukrea.fr>
	<571FBD5E.9040807@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:33836 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbcD0QrK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Apr 2016 12:47:10 -0400
Received: by mail-lf0-f44.google.com with SMTP id j11so63831207lfb.1
        for <linux-can@vger.kernel.org>; Wed, 27 Apr 2016 09:47:09 -0700 (PDT)
In-Reply-To: <571FBD5E.9040807@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?B?RXJpYyBCw6luYXJk?= <ebenard@eukrea.com>

On 26 April 2016 at 21:11, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> I wonder whether this small change covers the updates made between
> v3.0.1 and v3.1.0.
>

Probably not, I was mainly interested in fixing basic functionality here :)
(ie: with the default settings we can exchange data frames with
another controller)

>
> Your patch looks very good so far. I would appreciate if you could update the other register changes too as I don't have a hardware to test. I can provide the ISO/NON_ISO config for the netlink interface updates then :-)
>

Ok, I'll have another look at the changes. Thank you for the spec
history btw, it seems bosch only keeps the latest one publicly
available.

Regards,

Florian

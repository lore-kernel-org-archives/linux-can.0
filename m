From: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?=
        <remigiusz.kollataj@mobica.com>
Subject: Re: [PATCH] [RFC] can: add CAN interface termination API
Date: Sun, 8 Jan 2017 16:22:09 +0100
Message-ID: <CAKT-o-ddkBw8qo86DopN-VBDTx3qjUVg1FCWCwaSqTDaFF1VbQ@mail.gmail.com>
References: <20170107195807.16423-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:36370 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbdAHPWa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 8 Jan 2017 10:22:30 -0500
Received: by mail-ua0-f176.google.com with SMTP id 96so19971701uaq.3
        for <linux-can@vger.kernel.org>; Sun, 08 Jan 2017 07:22:30 -0800 (PST)
In-Reply-To: <20170107195807.16423-1-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Hi Oliver,

Looks good to me. Two minor comments below.

> +       if (data[IFLA_CAN_TERMINATION]) {
> +               u16 t = nla_get_u16(data[IFLA_CAN_TERMINATION]);
> +               int num_t = priv->termination_const_size / sizeof(u16);
> +               int i;
> +
> +               /* check whether given value is supported by the interface */
> +               for (i = 0; i < num_t && t != priv->termination_const[i]; i++);
> +               if (i >= num_t)
> +                       return -EINVAL;
> +
> +               priv->termination = t;

I would update the value after successful call to do_set_termination.

> +/* termination range: 1..65534 Ohms */
> +#define CAN_TERMINATION_DISABLED 0xFFFFU
> +

0 seems more natural to me. Why you are using 0xFFFF?

Regards,
Remik

From: Pieter Beyens <pieter.beyens@gmail.com>
Subject: Re: [PATCH] j1939: add SPDX-License-Identifier
Date: Mon, 29 Jan 2018 11:37:02 +0100
Message-ID: <CAA-_v_kTmRd38M=zjRLwaM9KO09pBvi3w-kk4QQk03H6ePTWcg@mail.gmail.com>
References: <20180124111808.8374-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:54602 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbeA2KhD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 Jan 2018 05:37:03 -0500
Received: by mail-wm0-f48.google.com with SMTP id i186so13167972wmi.4
        for <linux-can@vger.kernel.org>; Mon, 29 Jan 2018 02:37:03 -0800 (PST)
In-Reply-To: <20180124111808.8374-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be, kernel@pengutronix.de

Acked-by: Pieter Beyens <pieter.beyens@gmail.com>

On Wed, Jan 24, 2018 at 12:18 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Hello,
>
> I added a bnush of SPDX-License-Identifier to the files introduced in
> the j1939 patches.
>
> I marked include/uapi/linux/can/j1939.h as "GPL-2.0 WITH
> Linux-syscall-note" all other files as GPL-2.0.
>
> I'd like to have the Acked-by and or Signed-of by by Kurt and
> Pieter Beyens.
>
> regards,
> Marc
>
>  include/uapi/linux/can/j1939.h | 1 +
>  net/can/j1939/Kconfig          | 1 +
>  net/can/j1939/Makefile         | 2 ++
>  net/can/j1939/address-claim.c  | 1 +
>  net/can/j1939/bus.c            | 1 +
>  net/can/j1939/j1939-priv.h     | 1 +
>  net/can/j1939/main.c           | 1 +
>  net/can/j1939/socket.c         | 1 +
>  net/can/j1939/transport.c      | 1 +
>  9 files changed, 10 insertions(+)
>
> diff --git a/include/uapi/linux/can/j1939.h b/include/uapi/linux/can/j1939.h
> index cd4661a97906..306380656c03 100644
> --- a/include/uapi/linux/can/j1939.h
> +++ b/include/uapi/linux/can/j1939.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>  /*
>   * j1939.h
>   *
> diff --git a/net/can/j1939/Kconfig b/net/can/j1939/Kconfig
> index 74d2a863bc16..ff0b08a8af3f 100644
> --- a/net/can/j1939/Kconfig
> +++ b/net/can/j1939/Kconfig
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>  #
>  # SAE J1939 network layer core configuration
>  #
> diff --git a/net/can/j1939/Makefile b/net/can/j1939/Makefile
> index dda03af263f8..46e6c6ed221d 100644
> --- a/net/can/j1939/Makefile
> +++ b/net/can/j1939/Makefile
> @@ -1,3 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
>  cppflags-$(CONFIG_CAN_J1939_DEBUG) += -DDEBUG
>
>  obj-$(CONFIG_CAN_J1939) += can-j1939.o
> diff --git a/net/can/j1939/address-claim.c b/net/can/j1939/address-claim.c
> index ab538e1c4906..19e0bcf3e91f 100644
> --- a/net/can/j1939/address-claim.c
> +++ b/net/can/j1939/address-claim.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2010-2011 EIA Electronics
>   *
> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index fb6b701562c8..2d963cbdb0c7 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2010-2011 EIA Electronics
>   *
> diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
> index da37056ba5e5..e78420a99607 100644
> --- a/net/can/j1939/j1939-priv.h
> +++ b/net/can/j1939/j1939-priv.h
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * j1939-priv.h
>   *
> diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
> index 86cdcc18338a..4693c263ccd6 100644
> --- a/net/can/j1939/main.c
> +++ b/net/can/j1939/main.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2010-2011 EIA Electronics
>   *
> diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
> index ae5357510623..506ef86a9f7f 100644
> --- a/net/can/j1939/socket.c
> +++ b/net/can/j1939/socket.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2010-2011 EIA Electronics
>   *
> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 6001901c8db3..646efce90668 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2010-2011 EIA Electronics
>   *
> --
> 2.15.1
>
>
>



-- 
A designer knows he has achieved perfection not when there is nothing
left to add, but when there is nothing left to take away.
- Antoine de Saint-Exup'ery

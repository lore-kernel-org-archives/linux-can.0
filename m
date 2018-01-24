From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: [PATCH 4/4] j1939: remove proc support
Date: Wed, 24 Jan 2018 21:13:07 +0100
Message-ID: <20180124201307.GB4214@airbook.vandijck-laurijssen.be>
References: <20180124110659.438-1-o.rempel@pengutronix.de>
 <20180124110659.438-4-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b01.edpnet.be ([212.71.1.221]:59190 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752467AbeAXUNL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 24 Jan 2018 15:13:11 -0500
Content-Disposition: inline
In-Reply-To: <20180124110659.438-4-o.rempel@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de

Hey,

I'm in favor of stripping all unnecessary, but ...

> Date:   Wed, 24 Jan 2018 12:06:59 +0100
> From: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> to make upstreaming more simple, remove procfs support.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/networking/j1939.txt |  82 +----------------------
>  net/can/j1939/main.c               | 101 ----------------------------
>  net/can/j1939/transport.c          | 131 +------------------------------------
>  3 files changed, 5 insertions(+), 309 deletions(-)
> 
> diff --git a/Documentation/networking/j1939.txt b/Documentation/networking/j1939.txt
> index 08f7b035d821..d0e74df97baa 100644
> --- a/Documentation/networking/j1939.txt
> +++ b/Documentation/networking/j1939.txt
> @@ -36,18 +36,7 @@ This file contains
>      5.3 SO_J1939_RECV_OWN
>      5.4 SO_J1939_SEND_PRIO
>  
> -  6 can-j1939 procfs interface
> -    6.1 /proc/net/can-j1939/ecu
> -    6.2 /proc/net/can-j1939/filter
> -    6.3 /proc/net/can-j1939/sock
> -    6.4 /proc/net/can-j1939/transport

the ecu, filter & sock properties can be dropped, but huge transports,
like those in IsoBUS, remain hidden from an application, but it may be
usefull to indicate that a transfer is pending.
Such application relies on /proc/net/can-j1939/transport

> -
> -  7 can-j1939 SYSCTL
> -    7.1 /proc/sys/net/can-j1939/transport_max_payload_in_bytes
> -    7.2 /proc/sys/net/can-j1939/transport_cts_nr_of_frames
> -    7.3 /proc/sys/net/can-j1939/transport_tx_retry_ms

Those parameters shape the kernels behaviour on transport sessions.
It makes sense to configure them globally.
Should this be returned to module parameters then?

Kind regards,
Kurt

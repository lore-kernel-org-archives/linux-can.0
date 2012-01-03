From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] CAN MAINTAINERS update
Date: Tue, 03 Jan 2012 11:26:56 -0800
Message-ID: <1325618816.24257.5.camel@joe2Laptop>
References: <4F034B9C.2030106@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <4F034B9C.2030106@hartkopp.net>
Sender: netdev-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Linux Netdev List <netdev@vger.kernel.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, Urs Thuermann <urs.thuermann@volkswagen.de>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

On Tue, 2012-01-03 at 19:40 +0100, Oliver Hartkopp wrote:
> Update the CAN MAINTAINERS section:
> - add CAN development git repository URL to submit patches
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -1698,11 +1698,9 @@ F:	arch/x86/include/asm/tce.h
>  CAN NETWORK LAYER
[]
> +T:	git://gitorious.org/linux-can/linux-can-next.git
[]
> @@ -1713,9 +1711,10 @@ F:	include/linux/can/gw.h
>  CAN NETWORK DRIVERS
[]
> +T:	git://gitorious.org/linux-can/linux-can-next.git

Both of the "T:" lines should be:

T:	git git://gitorious.org/linux-can/linux-can-next.git

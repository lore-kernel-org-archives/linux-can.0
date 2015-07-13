From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: Fighting out-of-order reception with RPS?
Date: Mon, 13 Jul 2015 06:57:50 +0200
Message-ID: <1436763470.24939.66.camel@edumazet-glaptop2.roam.corp.google.com>
References: <559D628C.5020100@hartkopp.net>
	 <CALx6S35OJHyr6iwfdtYW6P-ke2pmsmQ9BjO-D=qjgCHxwF7oew@mail.gmail.com>
	 <559E0CDF.7080309@hartkopp.net>
	 <CALx6S37JjusJ=+L3mXT0Dzf8XuU0+dgJQ7_Xn4U0nBtkf0gCHQ@mail.gmail.com>
	 <55A02CDB.6000302@hartkopp.net>
	 <1436589345.24939.56.camel@edumazet-glaptop2.roam.corp.google.com>
	 <55A2BCD8.4020303@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <55A2BCD8.4020303@hartkopp.net>
Sender: netdev-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Tom Herbert <tom@herbertland.com>, Linux Kernel Network Developers <netdev@vger.kernel.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Sunil Kovvuri <sunil.kovvuri@gmail.com>, Jonathon Reinhart <jonathon.reinhart@gmail.com>
List-Id: linux-can.vger.kernel.org

On Sun, 2015-07-12 at 21:15 +0200, Oliver Hartkopp wrote:

> E.g. with
> 
> 	skb_set_hash(skb, dev->ifindex, PKT_HASH_TYPE_L2);
> 
> and
> 
> 	echo f > /sys/class/net/can0/queues/rx-0/rps_cpus
> 
> I get properly ordered CAN frames - even with netif_rx() processed skbs. I
> just want to have this stuff to be enabled by default for CAN interfaces to
> kill the OOO frame issue.

I doubt your skb_set_hash() makes any difference.

RPS prefers a L4 hash anyway (skb_get_hash()), so flow dissection
happens.

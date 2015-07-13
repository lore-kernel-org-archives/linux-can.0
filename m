From: David Miller <davem@davemloft.net>
Subject: Re: Fighting out-of-order reception with RPS?
Date: Sun, 12 Jul 2015 20:22:41 -0700 (PDT)
Message-ID: <20150712.202241.2051134175805521232.davem@davemloft.net>
References: <55A02CDB.6000302@hartkopp.net>
	<1436589345.24939.56.camel@edumazet-glaptop2.roam.corp.google.com>
	<55A2BCD8.4020303@hartkopp.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <55A2BCD8.4020303@hartkopp.net>
Sender: netdev-owner@vger.kernel.org
To: socketcan@hartkopp.net
Cc: eric.dumazet@gmail.com, tom@herbertland.com, netdev@vger.kernel.org, linux-can@vger.kernel.org, sunil.kovvuri@gmail.com, jonathon.reinhart@gmail.com
List-Id: linux-can.vger.kernel.org

From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Sun, 12 Jul 2015 21:15:36 +0200

> Just some remarks about CAN and CAN frames as you suggest GRO which is
> completely pointless for CAN.

GRO may be pointless for CAN, but NAPI _definitely_ is useful for every
single network device, period.

So you should do NAPI for reasons outside of packet receive ordering,
and in return you'll have your packet ordering problem solved as well.

I really am stumped as to why you are avoiding NAPI so vehemently.

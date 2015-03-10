From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH] can: use sock_efree instead of own destructor
Date: Tue, 10 Mar 2015 05:22:23 -0700
Message-ID: <1425990143.8261.28.camel@edumazet-glaptop2.roam.corp.google.com>
References: <1425959300-27132-1-git-send-email-fw@strlen.de>
	 <54FE8BB0.9050508@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <54FE8BB0.9050508@hartkopp.net>
Sender: netdev-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, mkl@pengutronix.de, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

On Tue, 2015-03-10 at 07:14 +0100, Oliver Hartkopp wrote:

> the other callers use it in the same way so it's a good simplification.
> Btw. the name of sock_efree() is a bit misleading - nothing is free'd here.
> 
> Won't it be better to rename sock_efree(skb) with sock_put_skb(skb) or 
> something like that? sock_efree() has no comment why it's named like this.

I would prefer name stays as is. It eases searches in changelogs to not
change function names unless really needed, for backports and code
maintenance.


# git log | grep sock_efree
    net: merge cases where sock_efree and sock_edemux are the same function
    Since sock_efree and sock_demux are essentially the same code for non-TCP
    In addition I have added a destructor named sock_efree which is meant to

sock_efree was added in commit 62bccb8cdb69051b95a55ab0c489e3cab261c8ef

I guess Alexander chose the name close to sock_edemux() and sock_rfree() ones.

This makes sense to me at least.

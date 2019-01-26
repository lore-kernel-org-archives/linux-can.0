From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] [stable pre-4.8] can: bcm: check timer values before
 ktime conversion
Date: Sat, 26 Jan 2019 13:17:18 -0500
Message-ID: <20190126181718.GE30183@sasha-vm>
References: <20190124090842.2938-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190124090842.2938-1-socketcan@hartkopp.net>
Sender: stable-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: davem@davemloft.net, netdev@vger.kernel.org, stable@vger.kernel.org, linux-can@vger.kernel.org, lifeasageek@gmail.com, threeearcat@gmail.com, syzkaller@googlegroups.com, nautsch2@gmail.com, Kyungtae Kim <kt0755@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

On Thu, Jan 24, 2019 at 10:08:42AM +0100, Oliver Hartkopp wrote:
>Kyungtae Kim detected a potential integer overflow in bcm_[rx|tx]_setup()
>when the conversion into ktime multiplies the given value with NSEC_PER_USEC
>(1000).
>
>Reference: https://marc.info/?l=linux-can&m=154732118819828&w=2
>
>Add a check for the given tv_usec, so that the value stays below one second.
>Additionally limit the tv_sec value to a reasonable value for CAN related
>use-cases of 400 days and ensure all values to be positive.
>
>This patch is the pre-4.8 version of upstream commit 93171ba6f1deffd8

I can't find this commit id upstream, there's nothing with the same
subject name, nor does this code exist upstream. What's going on?

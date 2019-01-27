From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] [stable pre-4.8] can: bcm: check timer values before
 ktime conversion
Date: Sun, 27 Jan 2019 19:22:38 +0100
Message-ID: <8a72ffa5-dac5-6de8-f01e-dfbb98b1f024@hartkopp.net>
References: <20190124090842.2938-1-socketcan@hartkopp.net>
 <20190126181718.GE30183@sasha-vm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190126181718.GE30183@sasha-vm>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, stable@vger.kernel.org, linux-can@vger.kernel.org, lifeasageek@gmail.com, threeearcat@gmail.com, syzkaller@googlegroups.com, nautsch2@gmail.com, Kyungtae Kim <kt0755@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

Hi Sasha,

On 26.01.19 19:17, Sasha Levin wrote:
> On Thu, Jan 24, 2019 at 10:08:42AM +0100, Oliver Hartkopp wrote:
>> Kyungtae Kim detected a potential integer overflow in bcm_[rx|tx]_setup()
>> when the conversion into ktime multiplies the given value with 
>> NSEC_PER_USEC
>> (1000).
>>
>> Reference: https://marc.info/?l=linux-can&m=154732118819828&w=2
>>
>> Add a check for the given tv_usec, so that the value stays below one 
>> second.
>> Additionally limit the tv_sec value to a reasonable value for CAN related
>> use-cases of 400 days and ensure all values to be positive.
>>
>> This patch is the pre-4.8 version of upstream commit 93171ba6f1deffd8
> 
> I can't find this commit id upstream, there's nothing with the same
> subject name, nor does this code exist upstream. What's going on?

Here we are (pulled by Linus some minutes ago):

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=93171ba6f1deffd82f381d36cb13177872d023f6

Can you go with this pre-4.8 version now?

Many thanks,
Oliver

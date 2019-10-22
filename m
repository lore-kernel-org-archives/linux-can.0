From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v2] net: sch_generic: Use pfifo_fast as fallback scheduler
 for CAN hardware
Date: Tue, 22 Oct 2019 20:21:08 +0200
Message-ID: <894a5426-b649-fd51-9aad-e66543374b9e@hartkopp.net>
References: <20190327165632.10711-1-mkl@pengutronix.de>
 <1571750597-14030-1-git-send-email-vincent.prince.fr@gmail.com>
 <84b8ce24-fe5d-ead0-0d1d-03ea24b36f71@pengutronix.de>
 <20191022094254.489fd6a4@hermes.lan>
 <b810b1b7-de82-a6ac-f063-5ee8a6460962@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <b810b1b7-de82-a6ac-f063-5ee8a6460962@gmail.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Eric Dumazet <eric.dumazet@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Prince <vincent.prince.fr@gmail.com>, jiri@resnulli.us, jhs@mojatatu.com, netdev@vger.kernel.org, dave.taht@gmail.com, linux-can@vger.kernel.org, kernel@pengutronix.de, xiyou.wangcong@gmail.com, davem@davemloft.net
List-Id: linux-can.vger.kernel.org


On 22/10/2019 19.28, Eric Dumazet wrote
> On 10/22/19 9:42 AM, Stephen Hemminger wrote:
> 
>> Why not fix fq_codel to return the same errors as other qdisc?
>>
> 
> I believe the same problem would happen with any qdisc not doing tail drops.
> 
> Do we really want to enforce all qdisc to have a common drop strategy ?

CAN has no drop strategy. There is no transport protocol at this point 
which can handle and compensate drops. CAN is just about PDUs that are 
sent on a special medium.

And that's what this patch was about.

> 
> For example, FQ could implement a strategy dropping the oldest packet in the queue,
> which is absolutely not related to the enqueue order.
> 

We have a CAN ID related ematch rule in em_canid.c to be able to 
configure HTBs, delays or drops. But this is for testing and special 
use-cases. Silently dropped frames are not expected.

Regards,
Oliver

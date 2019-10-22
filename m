From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH v2] net: sch_generic: Use pfifo_fast as fallback scheduler
 for CAN hardware
Date: Tue, 22 Oct 2019 10:28:26 -0700
Message-ID: <b810b1b7-de82-a6ac-f063-5ee8a6460962@gmail.com>
References: <20190327165632.10711-1-mkl@pengutronix.de>
 <1571750597-14030-1-git-send-email-vincent.prince.fr@gmail.com>
 <84b8ce24-fe5d-ead0-0d1d-03ea24b36f71@pengutronix.de>
 <20191022094254.489fd6a4@hermes.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191022094254.489fd6a4@hermes.lan>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Stephen Hemminger <stephen@networkplumber.org>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Prince <vincent.prince.fr@gmail.com>, jiri@resnulli.us, jhs@mojatatu.com, netdev@vger.kernel.org, dave.taht@gmail.com, linux-can@vger.kernel.org, kernel@pengutronix.de, xiyou.wangcong@gmail.com, davem@davemloft.net
List-Id: linux-can.vger.kernel.org



On 10/22/19 9:42 AM, Stephen Hemminger wrote:

> Why not fix fq_codel to return the same errors as other qdisc?
> 

I believe the same problem would happen with any qdisc not doing tail drops.

Do we really want to enforce all qdisc to have a common drop strategy ?

For example, FQ could implement a strategy dropping the oldest packet in the queue,
which is absolutely not related to the enqueue order.

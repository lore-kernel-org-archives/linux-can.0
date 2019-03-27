From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] net: sch_generic: add flag IFF_FIFO_QUEUE to use
 pfifo_fast as default scheduler
Date: Wed, 27 Mar 2019 19:53:32 +0100
Message-ID: <20190327185332.s3cq6ttscyk7234v@pengutronix.de>
References: <20190327165632.10711-1-mkl@pengutronix.de>
 <20190327165632.10711-2-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190327165632.10711-2-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Dave Taht <dave.taht@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>, kernel@pengutronix.de, Cong Wang <xiyou.wangcong@gmail.com>, linux-can@vger.kernel.org, davem@davemloft.net
List-Id: linux-can.vger.kernel.org

On Wed, Mar 27, 2019 at 05:56:31PM +0100, Marc Kleine-Budde wrote:
> There is networking hardware that isn't based on Ethernet for layers 1 and 2.
> 
> For example CAN.
> 
> CAN is a multi-master serial bus standard for connecting Electronic Control
> Units [ECUs] also known as nodes. A frame on the CAN bus carries up to 8 bytes
> of payload. Frame corruption is detected by a CRC. However frame loss due to
> corruption is possible, but a quite unusual phenomenon.
> 
> While fq_codel works great for TCP/IP, it doesn't for CAN. There are a lot of
> legacy protocols on top of CAN, which are not build with flow control or high
> CAN frame drop rates in mind.
> 
> When using fq_codel, as soon as the queue reaches a certain delay based length,
> skbs from the head of the queue are silently dropped. Silently meaning that the
> user space using a send() or similar syscall doesn't get an error. However
> TCP's flow control algorithm will detect dropped packages and adjust the

s/package/packet/ here and in a few more locations in this commit log.

> bandwidth accordingly.
> 
> When using fq_codel and sending raw frames over CAN, which is the common use
> case, the user space thinks the package has been sent without problems, because
> send() returned without an error. pfifo_fast will drop skbs, if the queue
> length exceeds the maximum. But with this scheduler the skbs at the tail are
> dropped, an error (-ENOBUFS) is propagated to user space. So that the user
> space can slow down the package generation.
> 
> On distributions, where fq_codel is made default via CONFIG_DEFAULT_NET_SCH
> during compile time, or set default during runtime with sysctl
> net.core.default_qdisc (see [1]), we get a bad user experience. In my test case
> with pfifo_fast, I can transfer thousands of million CAN frames without a frame
> drop. On the other hand with fq_codel there is more then one lost CAN frame per
> thousand frames.
> 
> As pointed out fq_codel is not suited for CAN hardware, so this patch
> introduces a new netdev_priv_flag called "IFF_FIFO_QUEUE" (in contrast to the
> existing "IFF_NO_QUEUE").
> 
> During transition of a netdev from down to up state the default queuing
> discipline is attached by attach_default_qdiscs() with the help of
> attach_one_default_qdisc(). This patch modifies attach_one_default_qdisc() to
> attach the pfifo_fast (pfifo_fast_ops) if the "IFF_FIFO_QUEUE" flag is set.
> 
> [1] https://github.com/systemd/systemd/issues/9194
> 
> Cc: Dave Taht <dave.taht@gmail.com>
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  include/linux/netdevice.h | 3 +++
>  net/sched/sch_generic.c   | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 166fdc0a78b4..1867e27e3369 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1498,6 +1498,7 @@ struct net_device_ops {
>   * @IFF_FAILOVER: device is a failover master device
>   * @IFF_FAILOVER_SLAVE: device is lower dev of a failover master device
>   * @IFF_L3MDEV_RX_HANDLER: only invoke the rx handler of L3 master device
> + * @IFF_FIFO_QUEUE: device must run with FIFO qdisc attached. skb drop without NET_XMIT_DROP is fatal

Do you need the FIFO property or only that the qdisc doesn't silently
drop packets? I don't know which other qdiscs are around, but depending
on the answer to this question other than pfifo_fast might be suitable?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC v3 1/7] pch_can: add spinlocks to protect tx objects
Date: Fri, 21 Jun 2013 12:11:35 +0200
Message-ID: <51C426D7.7050502@grandegger.com>
References: <1355260735-18994-1-git-send-email-wg@grandegger.com> <1355260735-18994-2-git-send-email-wg@grandegger.com> <CAGY4fa-e6foJTzX9cKhNKgeJHfmyi_QsvO8k+94YVzHVM+BAtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:40332 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824Ab3FUKLh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 21 Jun 2013 06:11:37 -0400
In-Reply-To: <CAGY4fa-e6foJTzX9cKhNKgeJHfmyi_QsvO8k+94YVzHVM+BAtw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mike Pellegrini <mikep86@gmail.com>
Cc: linux-can@vger.kernel.org, Alexander.Stein@systec-electronic.com, Christian.Bendele@gmx.net, bhupesh.sharma@st.com

Hi Mike,

On 06/20/2013 04:23 PM, Mike Pellegrini wrote:
> I believe I have found a bug in this changelist.  When applying these
> changes to the standard pch_can driver which ships with Ubuntu 12.04
> (kernel version 3.2.0-24.39), the race condition is still present and data
> transmission ceases after a short period of time.
> 
> I applied the following modification and the data transmission problem went
> away:
> 
> diff -c c-can-pci-v7/pch_can.c c-can-pci-v7-mrp/pch_can.c
> *** c-can-pci-v7/pch_can.c 2012-11-25 05:09:13.000000000 -0500
> --- c-can-pci-v7-mrp/pch_can.c 2012-11-26 11:29:11.350012074 -0500
> ***************
> *** 921,928 ****
>   priv->tx_obj++;
>   }
> 
> - spin_unlock_irqrestore(&priv->lock, flags);
> -
>   /* Setting the CMASK register. */
>   pch_can_bit_set(&priv->regs->ifregs[1].cmask, PCH_CMASK_ALL);
> 
> --- 921,926 ----
> ***************
> *** 957,962 ****
> --- 955,962 ----
> 
>   pch_can_rw_msg_obj(&priv->regs->ifregs[1].creq, tx_obj_no);
> 
> + spin_unlock_irqrestore(&priv->lock, flags);
> +
>   return NETDEV_TX_OK;
>   }
> 
> This modification was suggested by Wolfgang during testing many months back
> (I found it in my archive of test code); I think it got lost during the
> shuffle between versions.

Yes, I know. These patches did not go mainline yet because we know that
this driver does have other issues. Unfortunately the same is true for
the C_CAN based driver for the PCH I posted some time ago. That's a bad
situation but so far nobody with a hardware at hand made real progress
on the remaining issues. Maybe I should push my current patches
mainline, especially to introduce the C_CAN based driver.. and to make
the pch_can driver finally deprecated (or even remove it).

Wolfgang.


> 
> - Mike
> 
> 
> On Tue, Dec 11, 2012 at 4:18 PM, Wolfgang Grandegger <wg@grandegger.com>wrote:
> 
>> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
>> ---
>>  drivers/net/can/pch_can.c |   11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
>> index 7d17485..af61961 100644
>> --- a/drivers/net/can/pch_can.c
>> +++ b/drivers/net/can/pch_can.c
>> @@ -182,6 +182,7 @@ struct pch_can_priv {
>>         struct napi_struct napi;
>>         int tx_obj;     /* Point next Tx Obj index */
>>         int use_msi;
>> +       spinlock_t lock;        /* to protect tx objects */
>>  };
>>
>>  static const struct can_bittiming_const pch_can_bittiming_const = {
>> @@ -722,8 +723,11 @@ static void pch_can_tx_complete(struct net_device
>> *ndev, u32 int_stat)
>>  {
>>         struct pch_can_priv *priv = netdev_priv(ndev);
>>         struct net_device_stats *stats = &(priv->ndev->stats);
>> +       unsigned long flags;
>>         u32 dlc;
>>
>> +       spin_lock_irqsave(&priv->lock, flags);
>> +
>>         can_get_echo_skb(ndev, int_stat - PCH_RX_OBJ_END - 1);
>>         iowrite32(PCH_CMASK_RX_TX_GET | PCH_CMASK_CLRINTPND,
>>                   &priv->regs->ifregs[1].cmask);
>> @@ -734,6 +738,8 @@ static void pch_can_tx_complete(struct net_device
>> *ndev, u32 int_stat)
>>         stats->tx_packets++;
>>         if (int_stat == PCH_TX_OBJ_END)
>>                 netif_wake_queue(ndev);
>> +
>> +       spin_unlock_irqrestore(&priv->lock, flags);
>>  }
>>
>>  static int pch_can_poll(struct napi_struct *napi, int quota)
>> @@ -894,6 +900,7 @@ static netdev_tx_t pch_xmit(struct sk_buff *skb,
>> struct net_device *ndev)
>>  {
>>         struct pch_can_priv *priv = netdev_priv(ndev);
>>         struct can_frame *cf = (struct can_frame *)skb->data;
>> +       unsigned long flags;
>>         int tx_obj_no;
>>         int i;
>>         u32 id2;
>> @@ -901,6 +908,8 @@ static netdev_tx_t pch_xmit(struct sk_buff *skb,
>> struct net_device *ndev)
>>         if (can_dropped_invalid_skb(ndev, skb))
>>                 return NETDEV_TX_OK;
>>
>> +       spin_lock_irqsave(&priv->lock, flags);
>> +
>>         tx_obj_no = priv->tx_obj;
>>         if (priv->tx_obj == PCH_TX_OBJ_END) {
>>                 if (ioread32(&priv->regs->treq2) & PCH_TREQ2_TX_MASK)
>> @@ -911,6 +920,8 @@ static netdev_tx_t pch_xmit(struct sk_buff *skb,
>> struct net_device *ndev)
>>                 priv->tx_obj++;
>>         }
>>
>> +       spin_unlock_irqrestore(&priv->lock, flags);
>> +
>>         /* Setting the CMASK register. */
>>         pch_can_bit_set(&priv->regs->ifregs[1].cmask, PCH_CMASK_ALL);
>>
>> --
>> 1.7.9.5
>>
>>
> 


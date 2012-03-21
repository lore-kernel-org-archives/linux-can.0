From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [RFC] can: Introducing CANFD for af_can & can-raw
Date: Wed, 21 Mar 2012 12:05:02 +0100
Message-ID: <20120321110502.GA3372@vandijck-laurijssen.be>
References: <20120321091055.GA433@vandijck-laurijssen.be>
 <E1SAIM4-0007a6-Sf@smtprelay03.ispgateway.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:47930 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932240Ab2CULFH (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 21 Mar 2012 07:05:07 -0400
Content-Disposition: inline
In-Reply-To: <E1SAIM4-0007a6-Sf@smtprelay03.ispgateway.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: dev@sebastianhaas.info
Cc: linux-can@vger.kernel.org

Hi Sebastian,

On the ICC, Bosch presentend CANFD[1].
I'll share my interpretation:
* CANFD is meant as a successor of CAN.
* it addressess data throughput in 2 ways:
  - higher data bitrate for data using a second
    set of bittimings.
  - longer message payload (up to 64 byte).
* it remains very compatible to CAN, although _NOT_
  bus-compatible (ie. you put it on a seperate bus).

On ICC already, both Oliver & I thought that integrating
this into linux-can would be interesting, especially to
reamain binary compatible.

So I share my effort on the list as RFC :-).

[1]: http://www.semiconductors.bosch.de/media/pdf/canliteratur/can_fd.pdf

Kind regards,

Kurt

On Wed, Mar 21, 2012 at 11:01:20AM +0100, dev@sebastianhaas.info wrote:
> For everyone not included in the discussion at the ICC: What is the background?
>Am 21.03.2012 10:11 schrieb Kurt Van Dijck &lt;kurt.van.dijck@eia.be&gt;: <br></span>Hi,
>> Hi,
>> 
>> I thought a bit about the CANFD ideas from last ICC.
>> 
>> The patch below is a working prototype that extends
>> the frame format to 64 bytes. I explicitely did not
>> recompile userspace programs to see if current programs
>> still operate. candump & cansend do still work.
>> I did not try any other.
>> 
>> This is intended as a proof of concept that it is
>> possible to extend the ABI towards bigger CAN frames.
>> 
>> Next step could be to operate a vcan bus with bigger CAN frames.
>> 
>> Kurt
>> ---
>> can: Introducing CANFD for af_can & can-raw
>> 
>> struct can_frame is expanded to contain 64byte.
>> This patch extends the ABI, while staying compatible
>> with the existing one.
>> This patch does not introduce CANFD for chip drivers.
>> 
>> Signed-off-by: Kurt Van Dijck <kurt.van.dijck@eia.be>
>> 
>> diff --git a/include/linux/can.h b/include/linux/can.h
>> index f4cd17c..ea73a89 100644
>> --- a/include/linux/can.h
>> +++ b/include/linux/can.h
>> @@ -55,7 +55,7 @@ typedef __u32 can_err_mask_t;
>>  struct can_frame {
>>  	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
>>  	__u8    can_dlc; /* data length code: 0 .. 8 */
>> -	__u8    data[8] __attribute__((aligned(8)));
>> +	__u8    data[64] __attribute__((aligned(8)));
>>  };
>>  
>>  /* particular protocols of the protocol family PF_CAN */
>> diff --git a/include/linux/can/core.h b/include/linux/can/core.h
>> index 9716670..01f0923 100644
>> --- a/include/linux/can/core.h
>> +++ b/include/linux/can/core.h
>> @@ -89,4 +89,15 @@ extern void can_rx_unregister(struct net_device *dev, canid_t can_id,
>>  extern int can_send(struct sk_buff *skb, int loop);
>>  extern int can_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
>>  
>> +/**
>> + * LEGACY CAN frame
>> + * struct can20b_frame - basic CAN 2.0B frame structure
>> + * differs only payload size from struct can_frame
>> + */
>> +struct can20b_frame {
>> +	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
>> +	__u8    can_dlc; /* data length code: 0 .. 8 */
>> +	__u8    data[8] __attribute__((aligned(8)));
>> +};
>> +
>>  #endif /* CAN_CORE_H */
>> diff --git a/net/can/af_can.c b/net/can/af_can.c
>> index 8cd9e2e..1ddc8bc 100644
>> --- a/net/can/af_can.c
>> +++ b/net/can/af_can.c
>> @@ -221,13 +221,22 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
>>   *  -EPERM when trying to send on a non-CAN interface
>>   *  -EINVAL when the skb->data does not contain a valid CAN frame
>>   */
>> +#define CANFD_PADSIZE	(sizeof(struct can_frame) - sizeof(struct can20b_frame))
>>  int can_send(struct sk_buff *skb, int loop)
>>  {
>>  	struct sk_buff *newskb = NULL;
>>  	struct can_frame *cf = (struct can_frame *)skb->data;
>>  	int err;
>>  
>> -	if (skb->len != sizeof(struct can_frame) || cf->can_dlc > 8) {
>> +	if (skb->len == sizeof(struct can20b_frame))
>> +		/*
>> +		 * extend the skb to the new CAN frame format
>> +		 * fill with zero
>> +		 */
>> +		memset(skb_put(skb, CANFD_PADSIZE), 0, CANFD_PADSIZE);
>> +
>> +	if (skb->len != sizeof(struct can_frame) ||
>> +			(cf->can_dlc > sizeof(cf->data))) {
>>  		kfree_skb(skb);
>>  		return -EINVAL;
>>  	}
>> diff --git a/net/can/raw.c b/net/can/raw.c
>> index fbdd260..3471d22 100644
>> --- a/net/can/raw.c
>> +++ b/net/can/raw.c
>> @@ -662,7 +662,8 @@ static int raw_sendmsg(struct kiocb *iocb, struct socket *sock,
>>  	} else
>>  		ifindex = ro->ifindex;
>>  
>> -	if (size != sizeof(struct can_frame))
>> +	if ((size != sizeof(struct can_frame)) &&
>> +			(size != sizeof(struct can20b_frame)))
>>  		return -EINVAL;
>>  
>>  	dev = dev_get_by_index(&init_net, ifindex);

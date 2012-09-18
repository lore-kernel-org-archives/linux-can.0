From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v2] can: sja1000: Add support for listen-only mode and
 one-shot mode
Date: Tue, 18 Sep 2012 19:23:51 +0200
Message-ID: <5058AE27.5020406@hartkopp.net>
References: <5058994E.8000501@gaisler.com> <1347986041-5358-1-git-send-email-andreas@gaisler.com> <5058AC95.5070406@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:26729 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890Ab2IRRXx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Sep 2012 13:23:53 -0400
In-Reply-To: <5058AC95.5070406@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Andreas Larsson <andreas@gaisler.com>
Cc: linux-can@vger.kernel.org, software@gaisler.com

On 18.09.2012 19:17, Marc Kleine-Budde wrote:

> On 09/18/2012 06:34 PM, Andreas Larsson wrote:


>>  	unsigned char status = priv->read_reg(priv, REG_MOD);
>>  	int i;
>> +	u8 mod;
> 	u8 mod = 0;
> 
> Why inside the loop, see below? Better do it here:
> 
> 	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> 		mod |= MOD_LOM;
> 
> (The compiler would probably move it out of the loop anyway)
> 
>>  
>>  	for (i = 0; i < 100; i++) {
>>  		/* check reset bit */
>> @@ -156,7 +157,10 @@ static void set_normal_mode(struct net_device *dev)
>>  		}
>>  
>>  		/* set chip to normal mode */
>> -		priv->write_reg(priv, REG_MOD, 0x00);
>> +		mod = 0;
>> +		if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
>> +			mod |= MOD_LOM;
>> +		priv->write_reg(priv, REG_MOD, mod);
>>  		udelay(10);


What about using just the constants:

if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
	priv->write_reg(priv, REG_MOD, MOD_LOM);
else
	priv->write_reg(priv, REG_MOD, 0x00);

Which omits any experiments with extra variables ...

>>  		status = priv->read_reg(priv, REG_MOD);
>>  	}
>> @@ -278,6 +282,7 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
>>  	canid_t id;
>>  	uint8_t dreg;
>>  	int i;
>> +	u8 cmd;
>>  
>>  	if (can_dropped_invalid_skb(dev, skb))
>>  		return NETDEV_TX_OK;
>> @@ -310,7 +315,10 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
>>  
>>  	can_put_echo_skb(skb, dev, 0);
>>  
>> -	sja1000_write_cmdreg(priv, CMD_TR);
>> +	cmd = CMD_TR;
>> +	if (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
>> +		cmd |= CMD_AT;
>> +	sja1000_write_cmdreg(priv, cmd);


The same here:

if (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
	sja1000_write_cmdreg(priv, CMD_TR|CMD_AT);
else
	sja1000_write_cmdreg(priv, CMD_TR);


>>  
>>  	return NETDEV_TX_OK;
>>  }
>> @@ -605,7 +613,8 @@ struct net_device *alloc_sja1000dev(int sizeof_priv)
>>  	priv->can.do_set_mode = sja1000_set_mode;
>>  	priv->can.do_get_berr_counter = sja1000_get_berr_counter;
>>  	priv->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES |
>> -		CAN_CTRLMODE_BERR_REPORTING;
>> +		CAN_CTRLMODE_BERR_REPORTING | CAN_CTRLMODE_LISTENONLY |
>> +		CAN_CTRLMODE_ONE_SHOT;
>>  
>>  	spin_lock_init(&priv->cmdreg_lock);
>>  


Regards,
Oliver

From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH can-next v2] can-gw: add a variable limit for CAN frame
 routings
Date: Wed, 09 Jan 2013 20:52:14 +0100
Message-ID: <50EDCA6E.4020505@hartkopp.net>
References: <50EDA7EA.1070206@hartkopp.net> <50EDA9C6.8030409@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:61523 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932231Ab3AITwQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 9 Jan 2013 14:52:16 -0500
In-Reply-To: <50EDA9C6.8030409@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Linux CAN List <linux-can@vger.kernel.org>

On 09.01.2013 18:32, Marc Kleine-Budde wrote:

> On 01/09/2013 06:24 PM, Oliver Hartkopp wrote:


>>  static __initconst const char banner[] =
>> -	KERN_INFO "can: netlink gateway (rev " CAN_GW_VERSION ")\n";
>> +	KERN_INFO "can: netlink gateway (rev " CAN_GW_VERSION ")";
> 
> can you remove the KERN_INFO and make the printk(); a pr_info();


Yep.

> 
>>  
>>  MODULE_DESCRIPTION("PF_CAN netlink gateway");
>>  MODULE_LICENSE("Dual BSD/GPL");
>>  MODULE_AUTHOR("Oliver Hartkopp <oliver.hartkopp@volkswagen.de>");
>>  MODULE_ALIAS("can-gw");
>>  
>> +#define CGW_MIN_HOPS 1
>> +#define CGW_MAX_HOPS 6
>> +
>> +static unsigned int max_hops __read_mostly = CGW_MIN_HOPS;
>> +module_param(max_hops, uint, S_IRUGO);
>> +MODULE_PARM_DESC(max_hops,
>> +		 "maximum can-gw routing hops for CAN frames "
>> +		 "(valid values: 1-6 hops, default: 1)");
> 
> I think you can work with __stringify() to avoid hardcoding the 1 and 6
> here, e.g.:
> 
> "(valid values: "
> 	__stringify(CGW_MIN_HOPS) "-"
> 	__stringify(CGW_MAX_HOPS)
> 


Indeed i felt uncomfortable coding the same value two times ... but i was not
aware of the __stringify() directive. Tnx for the hint.

v3 is coming soon.

Regards,
Oliver


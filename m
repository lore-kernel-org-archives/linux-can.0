From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] slip: sl_alloc(): remove unused parameter "dev_t line"
Date: Sat, 9 Dec 2017 18:28:10 +0100
Message-ID: <6a6847fe-ca1d-a357-f264-89cbce9a8a6e@hartkopp.net>
References: <20171208111859.6090-1-mkl@pengutronix.de>
 <39d83463-b20d-3739-7e84-f1f51919e9e5@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:35034 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbdLIR2U (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 9 Dec 2017 12:28:20 -0500
In-Reply-To: <39d83463-b20d-3739-7e84-f1f51919e9e5@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc: kernel@pengutronix.de, linux-can <linux-can@vger.kernel.org>



On 12/08/2017 12:22 PM, Marc Kleine-Budde wrote:
> Hello Oliver,
> 
> I've the corresponding slcan patch already in my queue.

Excellent :-)

Thanks,
Oliver

> 
> Marc
> 
> On 12/08/2017 12:18 PM, Marc Kleine-Budde wrote:
>> The first and only parameter of sl_alloc() is unused, so remove it.
>>
>> Fixes: 5342b77c4123 slip: ("Clean up create and destroy")
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>   drivers/net/slip/slip.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
>> index cc63102ca96e..8940417c30e5 100644
>> --- a/drivers/net/slip/slip.c
>> +++ b/drivers/net/slip/slip.c
>> @@ -731,7 +731,7 @@ static void sl_sync(void)
>>   
>>   
>>   /* Find a free SLIP channel, and link in this `tty' line. */
>> -static struct slip *sl_alloc(dev_t line)
>> +static struct slip *sl_alloc(void)
>>   {
>>   	int i;
>>   	char name[IFNAMSIZ];
>> @@ -809,7 +809,7 @@ static int slip_open(struct tty_struct *tty)
>>   
>>   	/* OK.  Find a free SLIP channel to use. */
>>   	err = -ENFILE;
>> -	sl = sl_alloc(tty_devnum(tty));
>> +	sl = sl_alloc();
>>   	if (sl == NULL)
>>   		goto err_exit;
>>   
>>
> 
> 

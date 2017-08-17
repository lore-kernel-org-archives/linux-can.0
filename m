From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [00/14] can: cleanup of af_can/raw + simplifying of ndev->ml_priv
 handling
Date: Thu, 17 Aug 2017 15:54:33 +0200
Message-ID: <551518df-734a-bea1-8685-eda3773b3474@hartkopp.net>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <351130f1-b68e-6c0a-a18c-294940816bba@hartkopp.net>
 <dd24463a-6c2a-11e0-3fe1-1cea40923485@pengutronix.de>
 <61b043fa-311c-dd8c-404c-65adcf8e987b@hartkopp.net>
 <7d2b8653-1706-61de-6bb7-7198087dca20@pengutronix.de>
 <c6c4857d-2c5a-9f4b-8800-b24c4bb05097@pengutronix.de>
 <7e01b315-3836-4e83-a03d-4ea407e75393@pengutronix.de>
 <37e54c7f-9085-fc6c-716f-a217e3939fa4@hartkopp.net>
 <9d84e955-bce1-a6e9-0d07-a4a2bab98e52@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:11193 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751369AbdHQNyf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Aug 2017 09:54:35 -0400
In-Reply-To: <9d84e955-bce1-a6e9-0d07-a4a2bab98e52@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

On 08/17/2017 03:17 PM, Marc Kleine-Budde wrote:

> The code gets complicated, as during NETDEV_REGISTER the malloc may
> fail. But we can cancel the register with return
> notifier_from_errno(-ENOMEM);

So this would lead to a netdevice completely failing to register then?
Nice!

>> With NETDEV_REGISTER the memory would be allocated. Ok.
>>
>> An how would the memory be free'd then?
> 
> NETDEV_UNREGISTER... But we have a problem, as j1939 needs per device
> memory, too. Which is kfree()ed in a NETDEV_UNREGISTER hook, too. The
> order of the hooks in not guaranteed.

Yes. That's the same problem I was working around with 
'd->remove_on_zero_entries' %-/

Just to get an impression about the j1939 data structures:

Would the per-device memory increase significantly when CAN_J1939 is 
enabled? Or is it some array of pointers which would be added?

Regards,
Oliver

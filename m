From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [00/14] can: cleanup of af_can/raw + simplifying of ndev->ml_priv
 handling
Date: Thu, 17 Aug 2017 15:13:13 +0200
Message-ID: <37e54c7f-9085-fc6c-716f-a217e3939fa4@hartkopp.net>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <351130f1-b68e-6c0a-a18c-294940816bba@hartkopp.net>
 <dd24463a-6c2a-11e0-3fe1-1cea40923485@pengutronix.de>
 <61b043fa-311c-dd8c-404c-65adcf8e987b@hartkopp.net>
 <7d2b8653-1706-61de-6bb7-7198087dca20@pengutronix.de>
 <c6c4857d-2c5a-9f4b-8800-b24c4bb05097@pengutronix.de>
 <7e01b315-3836-4e83-a03d-4ea407e75393@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:21795 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbdHQNNP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Aug 2017 09:13:15 -0400
In-Reply-To: <7e01b315-3836-4e83-a03d-4ea407e75393@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de



On 08/17/2017 03:06 PM, Marc Kleine-Budde wrote:

>>> No. Another approach is keep the memory allocation in the
>>> NETDEV_REGISTER hook, but refuse to start the netdev with NOTIFY_DONE.
>>
>> copy/paste confusion:
>> NOTIFY_STOP of course
> 
> Or even use notifier_from_errno

I still have no idea what you mean :-(

With NETDEV_REGISTER the memory would be allocated. Ok.

An how would the memory be free'd then?

Regards,
Oliver

From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [00/14] can: cleanup of af_can/raw + simplifying of ndev->ml_priv
 handling
Date: Thu, 17 Aug 2017 15:08:17 +0200
Message-ID: <b42a44ec-8178-267a-52b3-c06018114496@hartkopp.net>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <351130f1-b68e-6c0a-a18c-294940816bba@hartkopp.net>
 <dd24463a-6c2a-11e0-3fe1-1cea40923485@pengutronix.de>
 <61b043fa-311c-dd8c-404c-65adcf8e987b@hartkopp.net>
 <7d2b8653-1706-61de-6bb7-7198087dca20@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:36195 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbdHQNIT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Aug 2017 09:08:19 -0400
In-Reply-To: <7d2b8653-1706-61de-6bb7-7198087dca20@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de



On 08/17/2017 03:02 PM, Marc Kleine-Budde wrote:
> On 08/17/2017 02:57 PM, Oliver Hartkopp wrote:


>> Now you introduce a network layer data structure into the driver layer.
>> I'm not against this - and in fact I can see a bunch of advantages and
>> simplifications as you intended.
> 
>> But do you think it's a proper approach from the perspective of layer
>> separation?
> 
> No. Another approach is keep the memory allocation in the
> NETDEV_REGISTER hook,

ok.

> but refuse to start the netdev with NOTIFY_DONE.

?? What does this mean ??

> Then we can skip all the NULL pointer checks, too.

Regards,
Oliver

From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [00/14] can: cleanup of af_can/raw + simplifying of ndev->ml_priv
 handling
Date: Thu, 17 Aug 2017 14:57:43 +0200
Message-ID: <61b043fa-311c-dd8c-404c-65adcf8e987b@hartkopp.net>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <351130f1-b68e-6c0a-a18c-294940816bba@hartkopp.net>
 <dd24463a-6c2a-11e0-3fe1-1cea40923485@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:26301 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752562AbdHQM5v (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Aug 2017 08:57:51 -0400
In-Reply-To: <dd24463a-6c2a-11e0-3fe1-1cea40923485@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

Hi Marc,

On 08/17/2017 01:57 PM, Marc Kleine-Budde wrote:

> 
> Have you found some time to look at these issues?
> 

I'm going through the code just now ;-)

One question:

All the midlayer private stuff was also done to cleanly separate the 
network layer stuff in net/can from the driver layer stuff in 
drivers/net/can.

Now you introduce a network layer data structure into the driver layer.
I'm not against this - and in fact I can see a bunch of advantages and 
simplifications as you intended.

But do you think it's a proper approach from the perspective of layer 
separation?

Best,
Oliver


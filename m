From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Issues with SocketCAN
Date: Mon, 9 Jan 2017 18:40:00 +0100
Message-ID: <e9f7f95f-6df1-c1b9-ee0a-0987e0afd062@hartkopp.net>
References: <a4601513-6eb3-eef1-8245-11010d74e685@web.de>
 <67c0bc8f-2ee4-d64d-977b-a9c6e7d80779@hartkopp.net>
 <705a81dc-36f6-3022-9a8b-9c114608414c@web.de>
 <57cab00a-ecab-143b-8884-af888425f59b@hartkopp.net>
 <61b12351-36f4-6072-0a7c-3992779a1ae6@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:36754 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753654AbdAIRkE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Jan 2017 12:40:04 -0500
In-Reply-To: <61b12351-36f4-6072-0a7c-3992779a1ae6@web.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Josenhans <michael.josenhans@web.de>
Cc: linux-can@vger.kernel.org

On 01/08/2017 06:29 PM, Michael Josenhans wrote:

> For regression tests it is useful to reset the BCM of an interface or
> all interfaces, before starting the next command.
> Is there such a BCM reset command?

No. There was no use-case so far.

Closing the BCM socket removes all the jobs - or you have to do so by 
hand with TX/RX_DELETE.

Best regards,
Oliver

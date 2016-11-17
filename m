From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: About adding a new CAN-FD driver...
Date: Thu, 17 Nov 2016 21:20:08 +0100
Message-ID: <35164f73-1c31-1c80-d521-f2ab7ef68a00@hartkopp.net>
References: <d88756ae-0eb8-705d-e6a5-0e4532a8e28c@peak-system.com>
 <6d435ca7-dda2-5213-4fb1-bff663255746@hartkopp.net>
 <59fb4102-64e1-af16-7b98-8ac8e39f78f7@peak-system.com>
 <685ea82c-3457-35b0-0fff-9bfedf83256b@hartkopp.net>
 <a901ee28-7872-f1b6-63c8-c6840be4f454@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:24696 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbcKQUUT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Nov 2016 15:20:19 -0500
In-Reply-To: <a901ee28-7872-f1b6-63c8-c6840be4f454@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Stephane,

On 11/17/2016 11:22 AM, Stephane Grosjean wrote:
> I'm almost ready for pushing the stuff about CAN-FD over our PCIe boards
> but I'm back to you before, because in one of your previous email, you
> talked about "linux/include/linux/can/dev" directory as the better place
> to put a common header file for all of our CAN-FD interfaces.
>
> AFAIK this directory does not exist so far... Did you actually mean
> "linux/include/linux/can"? Or did you expect me to create the "dev"
> subdir with pushing the corresponding patch?

Yes. The latter.

I think putting controller specific include files directly into 
"linux/include/linux/can" is wrong in the way that the platform specific 
content has a separate directory too.

My initial suggestion was

linux/include/linux/can/dev/

but we may also think of

linux/include/linux/can/controller/
linux/include/linux/can/ctrl/
linux/include/linux/can/ip-core/
linux/include/linux/can/ctrl-core/
linux/include/linux/can/can-core/

'ip-core' seems a good name too as it reflects the CAN controller 
specific characteristics (e.g. memory register layout).

What would you suggest as directory name?

Regards,
Oliver


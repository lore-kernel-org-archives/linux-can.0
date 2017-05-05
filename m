From: "Romain Forlot [IoT.bzh]" <claneys@iot.bzh>
Subject: Re: Using CAN_FD_FRAME with BCM socket
Date: Fri, 5 May 2017 12:19:19 +0200
Message-ID: <a2dc8f51-77db-f4d2-783d-48f0acc1a217@iot.bzh>
References: <6e32a9c4-2a08-87ac-aa1e-88907db27304@iot.bzh>
 <a05f4636-3fa1-1d3f-4daf-e0173120609d@hartkopp.net>
 <7d495447-8785-9c2b-b2ce-850dcdeaf174@iot.bzh>
 <fcdec4f3-41b0-c248-24de-555474bc5dee@hartkopp.net>
 <cefbe7e3-6c84-55cf-e964-b73a2d8d3d72@iot.bzh>
 <74642ed6-012d-aaca-778a-c4a5af65fe3c@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33476 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751460AbdEEKTX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 May 2017 06:19:23 -0400
Received: by mail-wm0-f53.google.com with SMTP id n198so1885987wmg.0
        for <linux-can@vger.kernel.org>; Fri, 05 May 2017 03:19:21 -0700 (PDT)
In-Reply-To: <74642ed6-012d-aaca-778a-c4a5af65fe3c@hartkopp.net>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Hi Oliver,

Thanks for the links, I found out the same and make my test against the 
wrong device... My bad, once MTU correctly set, it works.

I hoping that even if BCM socket filter use of FD frames, it could 
handle classic CAN frame too, like the RAW socket do. It doesn't, so I 
guess that description about signals must specify if it's using FD 
frames or not. Be able to also handle classic CAN frames avoid that.

There is a limitation to not handle both ?

Best regards.

On 05/05/2017 10:31 AM, Oliver Hartkopp wrote:
> Hi Romain,
>
> On 05/04/2017 09:27 PM, Romain Forlot [IoT.bzh] wrote:
>> It is a virtual can interface. I will check how to enable it.
>
> https://github.com/linux-can/can-misc/blob/master/etc/can_if#L37
>
> http://lxr.linux.no/#linux+v4.10.1/Documentation/networking/can.txt#L1197
>
> http://lxr.linux.no/#linux+v4.10.1/Documentation/networking/can.txt#L605
>
> Regards,
> Oliver

-- 
Romain Forlot - Embedded Engineer - IoT.bzh
claneys@iot.bzh - www.iot.bzh - +33257620298


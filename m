From: "Romain Forlot [IoT.bzh]" <claneys@iot.bzh>
Subject: Re: Using CAN_FD_FRAME with BCM socket
Date: Thu, 4 May 2017 21:27:42 +0200
Message-ID: <cefbe7e3-6c84-55cf-e964-b73a2d8d3d72@iot.bzh>
References: <6e32a9c4-2a08-87ac-aa1e-88907db27304@iot.bzh>
 <a05f4636-3fa1-1d3f-4daf-e0173120609d@hartkopp.net>
 <7d495447-8785-9c2b-b2ce-850dcdeaf174@iot.bzh>
 <fcdec4f3-41b0-c248-24de-555474bc5dee@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:36855 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755159AbdEDT1v (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 May 2017 15:27:51 -0400
Received: by mail-wr0-f169.google.com with SMTP id l50so13070486wrc.3
        for <linux-can@vger.kernel.org>; Thu, 04 May 2017 12:27:50 -0700 (PDT)
In-Reply-To: <fcdec4f3-41b0-c248-24de-555474bc5dee@hartkopp.net>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

It is a virtual can interface. I will check how to enable it.


On 05/04/2017 08:21 PM, Oliver Hartkopp wrote:
> Hi Romain,
>
> On 05/04/2017 08:04 PM, Romain Forlot [IoT.bzh] wrote:
>> Message too long
>
> you are using CAN FD frames on a non CAN FD capable CAN interface.
>
> Right?
>
> Regards,
> Oliver

-- 
Romain Forlot - Embedded Engineer - IoT.bzh
claneys@iot.bzh - www.iot.bzh - +33257620298


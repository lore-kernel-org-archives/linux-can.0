From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Using CAN_FD_FRAME with BCM socket
Date: Fri, 5 May 2017 10:31:22 +0200
Message-ID: <74642ed6-012d-aaca-778a-c4a5af65fe3c@hartkopp.net>
References: <6e32a9c4-2a08-87ac-aa1e-88907db27304@iot.bzh>
 <a05f4636-3fa1-1d3f-4daf-e0173120609d@hartkopp.net>
 <7d495447-8785-9c2b-b2ce-850dcdeaf174@iot.bzh>
 <fcdec4f3-41b0-c248-24de-555474bc5dee@hartkopp.net>
 <cefbe7e3-6c84-55cf-e964-b73a2d8d3d72@iot.bzh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:13922 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751752AbdEEIba (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 May 2017 04:31:30 -0400
In-Reply-To: <cefbe7e3-6c84-55cf-e964-b73a2d8d3d72@iot.bzh>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Romain Forlot [IoT.bzh]" <claneys@iot.bzh>, linux-can@vger.kernel.org

Hi Romain,

On 05/04/2017 09:27 PM, Romain Forlot [IoT.bzh] wrote:
> It is a virtual can interface. I will check how to enable it.

https://github.com/linux-can/can-misc/blob/master/etc/can_if#L37

http://lxr.linux.no/#linux+v4.10.1/Documentation/networking/can.txt#L1197

http://lxr.linux.no/#linux+v4.10.1/Documentation/networking/can.txt#L605

Regards,
Oliver

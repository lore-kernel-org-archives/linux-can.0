From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Using CAN_FD_FRAME with BCM socket
Date: Thu, 4 May 2017 20:21:20 +0200
Message-ID: <fcdec4f3-41b0-c248-24de-555474bc5dee@hartkopp.net>
References: <6e32a9c4-2a08-87ac-aa1e-88907db27304@iot.bzh>
 <a05f4636-3fa1-1d3f-4daf-e0173120609d@hartkopp.net>
 <7d495447-8785-9c2b-b2ce-850dcdeaf174@iot.bzh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:27540 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbdEDSV2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 May 2017 14:21:28 -0400
In-Reply-To: <7d495447-8785-9c2b-b2ce-850dcdeaf174@iot.bzh>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Romain Forlot [IoT.bzh]" <claneys@iot.bzh>, linux-can@vger.kernel.org

Hi Romain,

On 05/04/2017 08:04 PM, Romain Forlot [IoT.bzh] wrote:
> Message too long

you are using CAN FD frames on a non CAN FD capable CAN interface.

Right?

Regards,
Oliver

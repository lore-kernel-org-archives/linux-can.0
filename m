From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Reading BCM socket.
Date: Tue, 25 Apr 2017 21:13:44 +0200
Message-ID: <96b97a2b-c8fb-f3f1-2c6e-b0efa28ab844@hartkopp.net>
References: <19408793-d028-4084-3d2a-f741dcf74577@iot.bzh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:24268 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1432239AbdDYTN7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Apr 2017 15:13:59 -0400
In-Reply-To: <19408793-d028-4084-3d2a-f741dcf74577@iot.bzh>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Romain Forlot [IoT.bzh]" <claneys@iot.bzh>, linux-can@vger.kernel.org

Hi Romain,

On 04/25/2017 05:03 PM, Romain Forlot [IoT.bzh] wrote:
> I playing around BCM socket and wondering if there is a preferred way to
> use them.
>
> For now, I use 1 BCM socket by device and adding or removing jobs, but I
> wonder if it isn't better to get 1 BCM socket by job or arbitration ID.

I would recommend 1 BCM socket per job.
The question is: How do you specify 'job'? :-)

> By ID it is possible to assign a socket to a CAN signal instead of a
> device, it could make sense.

In fact I would use a BCM socket for each signal (when a signal is 
something like 'vehicle speed', 'engine speed', 'door status', etc).

The idea is to put the filter into the kernel in the way that the 
application only gets an update when it has something to calculate.

E.g. for 'engine speed' you could also use the 'throttle' functionality 
(throttle 10ms CAN signal down to e.g. 200ms) which is only possible 
when you use a dedicated BCM socket for this signal.

Regards,
Oliver

>
> What do you think ? How do use that kind of socket in your apps ?
>
> Thanks.
>

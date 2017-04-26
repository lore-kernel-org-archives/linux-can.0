From: "Romain Forlot [IoT.bzh]" <claneys@iot.bzh>
Subject: Re: Reading BCM socket.
Date: Wed, 26 Apr 2017 09:35:32 +0200
Message-ID: <a1848b4c-85a5-1da5-a485-954d046a03bf@iot.bzh>
References: <19408793-d028-4084-3d2a-f741dcf74577@iot.bzh>
 <96b97a2b-c8fb-f3f1-2c6e-b0efa28ab844@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:35220 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1956385AbdDZHfh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Apr 2017 03:35:37 -0400
Received: by mail-wr0-f177.google.com with SMTP id z52so79110653wrc.2
        for <linux-can@vger.kernel.org>; Wed, 26 Apr 2017 00:35:36 -0700 (PDT)
In-Reply-To: <96b97a2b-c8fb-f3f1-2c6e-b0efa28ab844@hartkopp.net>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Ok, thanks.

Using one socket does the job too, I just adding filters using 1 BCM 
socket instead of 1 for each signals. There is a big socket containing 
all filters for the device, but it may be more convenient to use 
separated socket like you recommend, I'll go that way :-)

Parameters for filter is already presents in our signals description, 
throttling etc... So I just have to plug them.

On 04/25/2017 09:13 PM, Oliver Hartkopp wrote:
> Hi Romain,
>
> On 04/25/2017 05:03 PM, Romain Forlot [IoT.bzh] wrote:
>> I playing around BCM socket and wondering if there is a preferred way to
>> use them.
>>
>> For now, I use 1 BCM socket by device and adding or removing jobs, but I
>> wonder if it isn't better to get 1 BCM socket by job or arbitration ID.
>
> I would recommend 1 BCM socket per job.
> The question is: How do you specify 'job'? :-)
>
>> By ID it is possible to assign a socket to a CAN signal instead of a
>> device, it could make sense.
>
> In fact I would use a BCM socket for each signal (when a signal is 
> something like 'vehicle speed', 'engine speed', 'door status', etc).
>
> The idea is to put the filter into the kernel in the way that the 
> application only gets an update when it has something to calculate.
>
> E.g. for 'engine speed' you could also use the 'throttle' 
> functionality (throttle 10ms CAN signal down to e.g. 200ms) which is 
> only possible when you use a dedicated BCM socket for this signal.
>
> Regards,
> Oliver
>
>>
>> What do you think ? How do use that kind of socket in your apps ?
>>
>> Thanks.
>>
-- 
Romain Forlot - Embedded Engineer - IoT.bzh
claneys@iot.bzh - www.iot.bzh - +33257620298


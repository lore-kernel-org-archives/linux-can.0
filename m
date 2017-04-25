From: "Romain Forlot [IoT.bzh]" <claneys@iot.bzh>
Subject: Reading BCM socket.
Date: Tue, 25 Apr 2017 17:03:49 +0200
Message-ID: <19408793-d028-4084-3d2a-f741dcf74577@iot.bzh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:32844 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1948577AbdDYPDx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Apr 2017 11:03:53 -0400
Received: by mail-wr0-f177.google.com with SMTP id w50so87235681wrc.0
        for <linux-can@vger.kernel.org>; Tue, 25 Apr 2017 08:03:52 -0700 (PDT)
Received: from shamash.uruk.home (ARennes-659-1-166-117.w2-12.abo.wanadoo.fr. [2.12.149.117])
        by smtp.gmail.com with ESMTPSA id p26sm3943295wmi.18.2017.04.25.08.03.50
        for <linux-can@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 08:03:50 -0700 (PDT)
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi everyone,

I playing around BCM socket and wondering if there is a preferred way to 
use them.

For now, I use 1 BCM socket by device and adding or removing jobs, but I 
wonder if it isn't better to get 1 BCM socket by job or arbitration ID. 
By ID it is possible to assign a socket to a CAN signal instead of a 
device, it could make sense.

What do you think ? How do use that kind of socket in your apps ?

Thanks.

-- 
Romain Forlot - Embedded Engineer - IoT.bzh
claneys@iot.bzh - www.iot.bzh - +33257620298


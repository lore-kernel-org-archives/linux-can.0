From: "Romain Forlot [IoT.bzh]" <romain.forlot@iot.bzh>
Subject: Reading BCM socket.
Date: Tue, 25 Apr 2017 17:04:00 +0200
Message-ID: <2ef36688-0136-66b6-8716-a8a3b396693e@iot.bzh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wr0-f181.google.com ([209.85.128.181]:34073 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1431485AbdDYPEE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Apr 2017 11:04:04 -0400
Received: by mail-wr0-f181.google.com with SMTP id l9so8309306wre.1
        for <linux-can@vger.kernel.org>; Tue, 25 Apr 2017 08:04:03 -0700 (PDT)
Received: from shamash.uruk.home (ARennes-659-1-166-117.w2-12.abo.wanadoo.fr. [2.12.149.117])
        by smtp.gmail.com with ESMTPSA id p17sm4312788wmd.11.2017.04.25.08.04.01
        for <linux-can@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 08:04:01 -0700 (PDT)
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
romain.forlot@iot.bzh - www.iot.bzh - +33257620298


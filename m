From: Austin Hendrix <namniart@gmail.com>
Subject: Count dropped frames on CAN socket
Date: Tue, 15 Nov 2016 15:32:22 -0800
Message-ID: <519e768b-887e-0aad-9043-7b6b44a61122@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33180 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752604AbcKOXcY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Nov 2016 18:32:24 -0500
Received: by mail-pf0-f196.google.com with SMTP id 144so8653082pfv.0
        for <linux-can@vger.kernel.org>; Tue, 15 Nov 2016 15:32:24 -0800 (PST)
Received: from [172.16.132.36] (108-60-121-10.static.wiline.com. [108.60.121.10])
        by smtp.googlemail.com with ESMTPSA id r21sm46407277pfd.44.2016.11.15.15.32.22
        for <linux-can@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Nov 2016 15:32:23 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi linux-can,

I'm writing a program which receives CAN frames over SocketCAN. I've 
found on a couple of occasions that my program has had bugs that cause 
it not to empty the CAN socket receive buffer, and the kernel has 
dropped incoming CAN frames.

I had a look through the kernel source code, and found that the kernel's 
socket framework keeps track of dropped frames in the sk_drops field of 
the sock struct. Is there a way to retrieve that dropped frame counter 
from my program, so that it's easier for me to detect problems like this 
in the future? (I've looked in the docs and in /proc and haven't been 
able to find a way to retrieve the sk_drops counter, but it's quite 
possible that I missed something)


Thanks,

-Austin


From: =?UTF-8?Q?Micka=c3=abl_Gu=c3=a9rin?= <kael@crocobox.org>
Subject: using VCAN interfaces with containers
Date: Sun, 16 Oct 2016 15:22:41 +0200
Message-ID: <e2bccb97-c0b8-617b-a6e3-b273a05f48e8@crocobox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from cookie.crocobox.org ([5.135.166.110]:45837 "EHLO
        cookie.crocobox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755915AbcJPNbi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 16 Oct 2016 09:31:38 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

I have a software that I would like to test inside LXC or nspawn 
container. This software uses CAN and ethernet.

I need a way to have VCAN interface(s) allowing communication between 
host and container. (Something like veth ?)

 From what I know it is not possible to "peer" two VCAN interfaces. It's 
also not possible to have the same VCAN interface in two namespaces.


Can anyone tell me if this is possible (without sharing the same network 
namespace) ?

Thanks,

-- 
Mickaël.


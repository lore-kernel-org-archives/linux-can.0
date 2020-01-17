From: Andre Naujoks <nautsch2@gmail.com>
Subject: VCAN and CAN-FD DLC versus data length
Date: Fri, 17 Jan 2020 14:26:57 +0100
Message-ID: <ec6ffa3c-b208-b76a-d1ac-afd2fb1182a7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wm1-f43.google.com ([209.85.128.43]:38227 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgAQN1A (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 17 Jan 2020 08:27:00 -0500
Received: by mail-wm1-f43.google.com with SMTP id u2so7608028wmc.3
        for <linux-can@vger.kernel.org>; Fri, 17 Jan 2020 05:26:59 -0800 (PST)
Received: from ?IPv6:2a02:810d:1540:40aa:4118:28a8:49b0:1b37? ([2a02:810d:1540:40aa:4118:28a8:49b0:1b37])
        by smtp.gmail.com with ESMTPSA id s15sm31615174wrp.4.2020.01.17.05.26.58
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 05:26:58 -0800 (PST)
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi all.

I just ran into some curious behaviour with the vcan driver in regards 
to CAN-FD and the DLC.

If I send a CAN-FD frame with a length, which is not directly 
representable by the DLC field, the vcan driver conserves this value. 
E.g. a Length of 11 is sent and received in userspace, even though there 
is no DLC representation for 11.

I talked to a colleague about this and we could not think of a case, in 
which this behaviour presents a problem. It is just a small discrepancy 
from how a real CAN would behave.

cansend from the can-utils package actually makes sure not to use a data 
length, which is not directly representable. This is the output of a 
candump oagainst a patched version, which does not "fix" the length.

$ candump any & ./patched-cansend vcan0 123##011223344556677889900AA
   vcan0  123  [11]  11 22 33 44 55 66 77 88 99 00 AA

Does anyone have a real case, which would warrant a patch to the vcan 
driver to change this? Or should the CAN stack even return EINVAL on a 
data length, that is not representable?

Regards
   Andre

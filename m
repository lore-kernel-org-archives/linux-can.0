From: Michael Dressel <michael.dressel@desy.de>
Subject: reading from socket can
Date: Thu, 27 Jul 2017 15:40:36 +0200 (CEST)
Message-ID: <alpine.LNX.2.21.1707271530280.9093@mpslxdressel.desy.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp-o-1.desy.de ([131.169.56.154]:53206 "EHLO smtp-o-1.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751518AbdG0Nud (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 27 Jul 2017 09:50:33 -0400
Received: from smtp-map-1.desy.de (smtp-map-1.desy.de [131.169.56.66])
        by smtp-o-1.desy.de (DESY-O-1) with ESMTP id 78D642800EC
        for <linux-can@vger.kernel.org>; Thu, 27 Jul 2017 15:40:37 +0200 (CEST)
Received: from mpslxdressel.desy.de (mpslxdressel.desy.de [131.169.216.148])
        by smtp-intra-1.desy.de (DESY-INTRA-1) with ESMTP id 440613E901
        for <linux-can@vger.kernel.org>; Thu, 27 Jul 2017 15:40:37 +0200 (MEST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

is it guaranteed that a read on a SOCK_RAW  socket will always
return complete can_frames, if it returns data at all?

The documentation of "read" explicitly states, that it is not an error to
return with any number of bytes less than the "requested" number of
bytes.

I found calls to read in some applications taking it for granted
that read always returns full can_frames. And, having some very
rare issues not understood yet, I wonder if an error in reading
from the socket may cause this issues.

Actually I found a similar bug in a library for ModBus communication,
and there it was possible to verify that the issues came from using read
in a wrong way.

Cheers,
Michael



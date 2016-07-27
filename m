From: laurent vaudoit <laurent.vaudoit@gmail.com>
Subject: can-J1939 crash after rxtask timeout
Date: Wed, 27 Jul 2016 15:39:05 +0200
Message-ID: <CAA7hF3ykNM8Nn1-bnqsG2dHE-hrE2MBC3++O4HkSw7WaL5rq0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33839 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756264AbcG0NjI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2016 09:39:08 -0400
Received: by mail-lf0-f54.google.com with SMTP id l69so27609970lfg.1
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2016 06:39:07 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

Hi all,

Kurt, i've add a little time to investigate the problem related to this thread
http://thread.gmane.org/gmane.linux.can/8788/focus=8828


My problems seems to be a sort of deadlock.
The sequence is :
I receive a BAM message with no DT messages.
the rxtask tasklet is launched for the DT timeout.
In this tasklet, at the end, the put_session is called, which call the
destroy session function.

And in the destroy_session function, the tasklet_disable(rxtask) is called.
So if i understand well, we are in a tasket, and we want to disable this one.
But if i read the documentation on tasklet_disable, it says that the
function will busy-wait until the tasket end running.

Is there something i miss?
The problem seems present with the rtpatch, and not present without.


Best regards
Laurent

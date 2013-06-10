From: janusz.uzycki@elproma.com.pl
Subject: [PATCH 2/2] slcanpty: /dev/tty support for tests
Date: Mon, 10 Jun 2013 11:44:31 +0200
Message-ID: <5b163f3e26b882777deae9a0f3ba248c@beep.pl>
References: <2DAB3DC2841347E7AF7833620339B427@laptop2>
 <51AF950D.1050004@hartkopp.net> <8BA0AB4D19CC422597E52513948E2EF0@laptop2>
 <51B0D58F.2010401@hartkopp.net> <6f9fdd56db06e6029218834c526f7d15@beep.pl>
 <51B310DC.8040509@hartkopp.net> <5dedc0b6441b754aebf3b560756932b8@beep.pl>
 <2b96a7606efb82e512f328eb2260b4bd@beep.pl>
 <f4dc05d8086417bb0b0b3613a0e93311@beep.pl>
 <a6a53837d3a628d0a188d974acfd2597@beep.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailmxout15.mailmx.agnat.pl ([193.239.45.95]:33503 "EHLO
	mailmxout15.mailmx.agnat.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751647Ab3FJJo4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Jun 2013 05:44:56 -0400
In-Reply-To: <a6a53837d3a628d0a188d974acfd2597@beep.pl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Krzysztof Borgulski <k.borgulski@elproma.com.pl>

 From 4c6115b210b64cf93493c93b05f82c83a085fb73 Mon Sep 17 00:00:00 2001
 From: Janusz Uzycki <j.uzycki@elproma.com.pl>
Date: Fri, 7 Jun 2013 23:02:13 +0200
Subject: [PATCH 2/2] slcanpty: /dev/tty support for tests


Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---
  slcanpty.c | 4 ++++
  1 file changed, 4 insertions(+)

diff --git a/slcanpty.c b/slcanpty.c
index f312362..b7e8ed7 100644
--- a/slcanpty.c
+++ b/slcanpty.c
@@ -44,6 +44,7 @@
  /* maximum rx buffer len: extended CAN frame with timestamp */
  #define SLC_MTU (sizeof("T1111222281122334455667788EA5F\r")+1)
  #define DEVICE_NAME_PTMX "/dev/ptmx"
+#define DEVICE_NAME_TTY "/dev/tty"

  #define DEBUG

@@ -407,10 +408,13 @@ int main(int argc, char **argv)
                         " /dev/ttyc0 for the slcan application\n", 
argv[0]);
                 fprintf(stderr, "e.g. for pseudo-terminal '%s %s can0' 
creates"
                         " /dev/pts/N\n", argv[0], DEVICE_NAME_PTMX);
+               fprintf(stderr, "e.g. for pseudo-terminal '%s %s can0' 
uses"
+                       " console terminal (for testing purposes)\n", 
argv[0], DEVICE_NAME_TTY);
                 fprintf(stderr, "\n");
                 return 1;
         }

+       if (strcmp(argv[1], DEVICE_NAME_TTY) != 0)
         select_stdin = check_select_stdin();

         /* open pty */
--
1.7.11.3


From: Joachim Jaus <jaus@black-photon.de>
Subject: Several sockets on one interface in Python
Date: Fri, 31 May 2013 11:55:29 +0200
Message-ID: <51A87391.6010308@black-photon.de>
Reply-To: joachim.jaus@black-photon.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:56163 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203Ab3EaKBd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 31 May 2013 06:01:33 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi all,
this is my first email to this list, therefore I want start with a big 
"thank you" to all the people involved in the Linux CAN socket 
development, which has opened up a lot of interesting possibilities for 
sensor and machine control for me and my colleagues.

We would like to bind several sockets with different filter settings to 
one single CAN interface within the same application. Is that generally 
a safe thing to do (both in C and in Python)?
Is there a way to set filters on a CAN socket in Python similar to the 
implementation in C?

Background:
We are implementing a machine control system with several sensors and 
actuators communicating over the same CAN bus using the CAN-open protocol.
There are several control loops running simultaneously, each controlled 
by a python sub-process.
It would be convenient if each subprocess had several sockets, with each 
socket receiving only messages sent by a certain CAN-open node or a 
group of CAN-open nodes. That way, we could most easily receive all 
relevant messages (SDOs, PDOs, ...) from a specific node or group of nodes.

Best regards,
Joachim

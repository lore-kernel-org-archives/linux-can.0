From: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
Subject: SJA1000 loopback feature
Date: Mon, 16 Jun 2014 20:20:44 +0400
Message-ID: <CAEJ7JO2ejHBVANYWXxXe_DstXCW-hm9xzJYXifiU+RwYNS3M1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c1ec1cc166ad04fbf66810
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:54363 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899AbaFPQUp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Jun 2014 12:20:45 -0400
Received: by mail-oa0-f51.google.com with SMTP id j17so6153878oag.10
        for <linux-can@vger.kernel.org>; Mon, 16 Jun 2014 09:20:45 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

--001a11c1ec1cc166ad04fbf66810
Content-Type: text/plain; charset=UTF-8

Hello.

We have several logical units working on the same CAN interface of a
SJA1000-based CAN controller. We need them to communicate with each other even
in a situation of one physical node on the bus. Thus we need some kind of a
loopback functionality for that. Software loopback works fine aside from the
fact it is performed only after an actual transmission has happened (which is a
problem with a one-node bus).

There is a CAN_CTRLMODE_LOOPBACK netlink option, but I didn't find any
description of its semantics. And as far as I understand every controller
interpretes it in its own way. For example, MCP2510 implies the loopback mode is
a silent (listen-only) mode and Bosch C_CAN controller disregards actual
rx-input in this mode according to the documentation. Hence the first question
is: what does CAN_CTRLMODE_LOOPBACK mean precisely?

I've also found out that this option is not implemented for SJA1000. Actually,
SJA1000 has nothing called a "loopback" feature but instead it has a Self Test
Mode, that seems like a reasonable solution for our problem. In this mode no
acknowledgement is required for the successful transmission, so software
loopback is working. However, it is not in the SJA1000 driver at the moment.

It is also possible to have the hardware loopback for SJA1000 with the Self
Reception Request feature (a message is transmitted and received simultaneously,
not implemented in sja1000 module as well), although we don't need it for our
specific case.

So the next question is: how should we implement those features for SJA1000?

I attached a patch that adds support for the Self Test Mode using the
CAN_CTRLMODE_LOOPBACK netlink option. As it is not exactly a loopback mode we
enable with that option, it might be a better idea to have a separate one for
that, smth like CAN_CTRLMODE_SELF_TEST. What do you think?

Regards,
Nikita

--001a11c1ec1cc166ad04fbf66810
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-can-sja1000-add-Self-Test-Mode-support.patch"
Content-Disposition: attachment;
	filename="0001-can-sja1000-add-Self-Test-Mode-support.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hwhzjxg30

RnJvbSAxNWQ3YWJlYzZkNzJjMjA3YTc0MmIwMGMxYjUwYTZiMzJmNDI3MTdkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOaWtpdGEgRWR3YXJkIEJhcnV6ZGluIDxuZWJhcnV6ZGluQGx2
ay5jcy5tc3Uuc3U+CkRhdGU6IE1vbiwgMTYgSnVuIDIwMTQgMTc6MzQ6MTAgKzA0MDAKU3ViamVj
dDogW1BBVENIXSBjYW46IHNqYTEwMDA6IGFkZCBTZWxmIFRlc3QgTW9kZSBzdXBwb3J0CgpUaGlz
IGFkZHMgc3VwcG9ydCBmb3IgU0pBMTAwMCBTZWxmIFRlc3QgTW9kZSAobW9kZSBpbiB3aGljaCBD
QU4gY29udHJvbGxlciB3aWxsCnBlcmZvcm0gYSBzdWNjZXNzZnVsIHRyYW5zbWlzc2lvbiwgZXZl
biBpZiB0aGVyZSBpcyBubyBhY2tub3dsZWRnZSByZWNlaXZlZCkKdGhyb3VnaCB0aGUgdXNlIG9m
IENBTl9DVFJMTU9ERV9MT09QQkFDSyBuZXRsaW5rIG9wdGlvbi4KClNpZ25lZC1vZmYtYnk6IE5p
a2l0YSBFZHdhcmQgQmFydXpkaW4gPG5lYmFydXpkaW5AbHZrLmNzLm1zdS5zdT4KLS0tCiBkcml2
ZXJzL25ldC9jYW4vc2phMTAwMC9zamExMDAwLmMgfCAxMCArKysrKysrLS0tCiAxIGZpbGUgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L2Nhbi9zamExMDAwL3NqYTEwMDAuYyBiL2RyaXZlcnMvbmV0L2Nhbi9zamExMDAwL3Nq
YTEwMDAuYwppbmRleCA3MTY0YTk5Li42NTI2YTQ2IDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC9j
YW4vc2phMTAwMC9zamExMDAwLmMKKysrIGIvZHJpdmVycy9uZXQvY2FuL3NqYTEwMDAvc2phMTAw
MC5jCkBAIC0xNjAsNiArMTYwLDggQEAgc3RhdGljIHZvaWQgc2V0X25vcm1hbF9tb2RlKHN0cnVj
dCBuZXRfZGV2aWNlICpkZXYpCiAJCS8qIHNldCBjaGlwIHRvIG5vcm1hbCBtb2RlICovCiAJCWlm
IChwcml2LT5jYW4uY3RybG1vZGUgJiBDQU5fQ1RSTE1PREVfTElTVEVOT05MWSkKIAkJCXByaXYt
PndyaXRlX3JlZyhwcml2LCBTSkExMDAwX01PRCwgTU9EX0xPTSk7CisJCWVsc2UgaWYgKHByaXYt
PmNhbi5jdHJsbW9kZSAmIENBTl9DVFJMTU9ERV9MT09QQkFDSykKKwkJCXByaXYtPndyaXRlX3Jl
Zyhwcml2LCBTSkExMDAwX01PRCwgTU9EX1NUTSk7CiAJCWVsc2UKIAkJCXByaXYtPndyaXRlX3Jl
Zyhwcml2LCBTSkExMDAwX01PRCwgMHgwMCk7CiAKQEAgLTYyMiw5ICs2MjQsMTEgQEAgc3RydWN0
IG5ldF9kZXZpY2UgKmFsbG9jX3NqYTEwMDBkZXYoaW50IHNpemVvZl9wcml2KQogCXByaXYtPmNh
bi5kb19zZXRfYml0dGltaW5nID0gc2phMTAwMF9zZXRfYml0dGltaW5nOwogCXByaXYtPmNhbi5k
b19zZXRfbW9kZSA9IHNqYTEwMDBfc2V0X21vZGU7CiAJcHJpdi0+Y2FuLmRvX2dldF9iZXJyX2Nv
dW50ZXIgPSBzamExMDAwX2dldF9iZXJyX2NvdW50ZXI7Ci0JcHJpdi0+Y2FuLmN0cmxtb2RlX3N1
cHBvcnRlZCA9IENBTl9DVFJMTU9ERV8zX1NBTVBMRVMgfAotCQlDQU5fQ1RSTE1PREVfQkVSUl9S
RVBPUlRJTkcgfCBDQU5fQ1RSTE1PREVfTElTVEVOT05MWSB8Ci0JCUNBTl9DVFJMTU9ERV9PTkVf
U0hPVDsKKwlwcml2LT5jYW4uY3RybG1vZGVfc3VwcG9ydGVkID0gQ0FOX0NUUkxNT0RFX0xPT1BC
QUNLCisJCQkJICAgICB8IENBTl9DVFJMTU9ERV9MSVNURU5PTkxZCisJCQkJICAgICB8IENBTl9D
VFJMTU9ERV8zX1NBTVBMRVMKKwkJCQkgICAgIHwgQ0FOX0NUUkxNT0RFX09ORV9TSE9UCisJCQkJ
ICAgICB8IENBTl9DVFJMTU9ERV9CRVJSX1JFUE9SVElORzsKIAogCXNwaW5fbG9ja19pbml0KCZw
cml2LT5jbWRyZWdfbG9jayk7CiAKLS0gCjIuMC4wCgo=
--001a11c1ec1cc166ad04fbf66810--

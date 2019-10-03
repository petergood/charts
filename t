#!/usr/bin/env bash

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# !
# ! Note:
# !
# ! THIS SCRIPT HAS BEEN AUTOMATICALLY GENERATED USING
# ! swagger-codegen (https://github.com/swagger-api/swagger-codegen)
# ! FROM SWAGGER SPECIFICATION IN JSON.
# !
# ! Generated on: 2018-10-31T10:32:21.156Z
# !
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

#
# This is a Bash client for Onezone.
#
# LICENSE:
# http://www.apache.org/licenses/LICENSE-2.0.html
#
# CONTACT:
# info@onedata.org
#
# MORE INFORMATION:
# 
#

###############################################################################
#
# Make sure Bash is at least in version 4.3
#
###############################################################################
if ! ( (("${BASH_VERSION:0:1}" == "4")) && (("${BASH_VERSION:2:1}" >= "3")) ) \
  && ! (("${BASH_VERSION:0:1}" >= "5")); then
    echo ""
    echo "Sorry - your Bash version is ${BASH_VERSION}"
    echo ""
    echo "You need at least Bash 4.3 to run this script."
    echo ""
    exit 1
fi

###############################################################################
#
# Global variables
#
###############################################################################

##
# The filename of this script for help messages
script_name=`basename "$0"`

##
# Map for headers passed after operation as KEY:VALUE
declare -A header_arguments


##
# Map for operation parameters passed after operation as PARAMETER=VALUE
# These will be mapped to appropriate path or query parameters
# The values in operation_parameters are arrays, so that multiple values
# can be provided for the same parameter if allowed by API specification
declare -A operation_parameters

##
# This array stores the minimum number of required occurences for parameter
# 0 - optional
# 1 - required
declare -A operation_parameters_minimum_occurences
operation_parameters_minimum_occurences["addChildGroup:::id"]=1
operation_parameters_minimum_occurences["addChildGroup:::cid"]=1
operation_parameters_minimum_occurences["addGroupHandleService:::handleService"]=1
operation_parameters_minimum_occurences["addGroupHandleService:::id"]=1
operation_parameters_minimum_occurences["addGroupUser:::id"]=1
operation_parameters_minimum_occurences["addGroupUser:::uid"]=1
operation_parameters_minimum_occurences["addGroupUser:::privileges"]=0
operation_parameters_minimum_occurences["createChildGroupToken:::id"]=1
operation_parameters_minimum_occurences["createGroup:::data"]=1
operation_parameters_minimum_occurences["createGroupForGroup:::id"]=1
operation_parameters_minimum_occurences["createGroupForGroup:::group"]=1
operation_parameters_minimum_occurences["createGroupHandle:::handle"]=1
operation_parameters_minimum_occurences["createGroupHandle:::id"]=1
operation_parameters_minimum_occurences["createSpaceForGroup:::id"]=1
operation_parameters_minimum_occurences["createSpaceForGroup:::spaceName"]=0
operation_parameters_minimum_occurences["createUserGroupInviteToken:::id"]=1
operation_parameters_minimum_occurences["getChildGroup:::id"]=1
operation_parameters_minimum_occurences["getChildGroup:::cid"]=1
operation_parameters_minimum_occurences["getEffectiveChildGroup:::id"]=1
operation_parameters_minimum_occurences["getEffectiveChildGroup:::cid"]=1
operation_parameters_minimum_occurences["getEffectiveChildrenGroups:::id"]=1
operation_parameters_minimum_occurences["getEffectiveGroupHandle:::id"]=1
operation_parameters_minimum_occurences["getEffectiveGroupHandle:::hid"]=1
operation_parameters_minimum_occurences["getEffectiveGroupProvider:::id"]=1
operation_parameters_minimum_occurences["getEffectiveGroupProvider:::pid"]=1
operation_parameters_minimum_occurences["getEffectiveGroupSpace:::id"]=1
operation_parameters_minimum_occurences["getEffectiveGroupSpace:::sid"]=1
operation_parameters_minimum_occurences["getEffectiveGroupUser:::id"]=1
operation_parameters_minimum_occurences["getEffectiveGroupUser:::uid"]=1
operation_parameters_minimum_occurences["getEffectiveParentGroup:::id"]=1
operation_parameters_minimum_occurences["getEffectiveParentGroup:::pid"]=1
operation_parameters_minimum_occurences["getGroup:::id"]=1
operation_parameters_minimum_occurences["getGroupEffectiveHandleService:::id"]=1
operation_parameters_minimum_occurences["getGroupEffectiveHandleService:::hsid"]=1
operation_parameters_minimum_occurences["getGroupHandle:::id"]=1
operation_parameters_minimum_occurences["getGroupHandle:::hid"]=1
operation_parameters_minimum_occurences["getGroupHandleService:::id"]=1
operation_parameters_minimum_occurences["getGroupHandleService:::hsid"]=1
operation_parameters_minimum_occurences["getGroupSpace:::id"]=1
operation_parameters_minimum_occurences["getGroupSpace:::sid"]=1
operation_parameters_minimum_occurences["getGroupUser:::id"]=1
operation_parameters_minimum_occurences["getGroupUser:::uid"]=1
operation_parameters_minimum_occurences["getParentGroup:::id"]=1
operation_parameters_minimum_occurences["getParentGroup:::pid"]=1
operation_parameters_minimum_occurences["groupJoinSpace:::id"]=1
operation_parameters_minimum_occurences["groupJoinSpace:::data"]=0
operation_parameters_minimum_occurences["joinParentGroup:::id"]=1
operation_parameters_minimum_occurences["joinParentGroup:::data"]=0
operation_parameters_minimum_occurences["leaveParentGroup:::id"]=1
operation_parameters_minimum_occurences["leaveParentGroup:::pid"]=1
operation_parameters_minimum_occurences["listChildGroupPrivileges:::id"]=1
operation_parameters_minimum_occurences["listChildGroupPrivileges:::cid"]=1
operation_parameters_minimum_occurences["listChildGroups:::id"]=1
operation_parameters_minimum_occurences["listEffectiveChildGroupPrivileges:::id"]=1
operation_parameters_minimum_occurences["listEffectiveChildGroupPrivileges:::cid"]=1
operation_parameters_minimum_occurences["listEffectiveGroupHandleServices:::id"]=1
operation_parameters_minimum_occurences["listEffectiveGroupHandles:::id"]=1
operation_parameters_minimum_occurences["listEffectiveGroupPrivileges:::id"]=1
operation_parameters_minimum_occurences["listEffectiveGroupProviders:::id"]=1
operation_parameters_minimum_occurences["listEffectiveGroupSpaces:::id"]=1
operation_parameters_minimum_occurences["listEffectiveGroupUsers:::id"]=1
operation_parameters_minimum_occurences["listEffectiveParentGroups:::id"]=1
operation_parameters_minimum_occurences["listGroupHandleServices:::id"]=1
operation_parameters_minimum_occurences["listGroupHandles:::id"]=1
operation_parameters_minimum_occurences["listGroupOnezonePrivileges:::id"]=1
operation_parameters_minimum_occurences["listGroupSpaces:::id"]=1
operation_parameters_minimum_occurences["listGroupUsers:::id"]=1
operation_parameters_minimum_occurences["listGroupsUserPrivileges:::id"]=1
operation_parameters_minimum_occurences["listGroupsUserPrivileges:::uid"]=1
operation_parameters_minimum_occurences["listParentGroups:::id"]=1
operation_parameters_minimum_occurences["listUserGroupPrivileges:::id"]=1
operation_parameters_minimum_occurences["listUserGroupPrivileges:::uid"]=1
operation_parameters_minimum_occurences["modifyGroup:::id"]=1
operation_parameters_minimum_occurences["modifyGroup:::data"]=1
operation_parameters_minimum_occurences["removeChildGroup:::id"]=1
operation_parameters_minimum_occurences["removeChildGroup:::cid"]=1
operation_parameters_minimum_occurences["removeGroup:::id"]=1
operation_parameters_minimum_occurences["removeGroupFromSpace:::id"]=1
operation_parameters_minimum_occurences["removeGroupFromSpace:::sid"]=1
operation_parameters_minimum_occurences["removeGroupHandle:::id"]=1
operation_parameters_minimum_occurences["removeGroupHandle:::hid"]=1
operation_parameters_minimum_occurences["removeGroupHandleService:::id"]=1
operation_parameters_minimum_occurences["removeGroupHandleService:::hsid"]=1
operation_parameters_minimum_occurences["removeGroupOnezonePrivileges:::id"]=1
operation_parameters_minimum_occurences["removeGroupUser:::id"]=1
operation_parameters_minimum_occurences["removeGroupUser:::uid"]=1
operation_parameters_minimum_occurences["setChildGroupPrivileges:::id"]=1
operation_parameters_minimum_occurences["setChildGroupPrivileges:::cid"]=1
operation_parameters_minimum_occurences["setChildGroupPrivileges:::data"]=1
operation_parameters_minimum_occurences["setGroupOnezonePrivileges:::id"]=1
operation_parameters_minimum_occurences["setGroupOnezonePrivileges:::data"]=0
operation_parameters_minimum_occurences["setUserGroupPrivileges:::id"]=1
operation_parameters_minimum_occurences["setUserGroupPrivileges:::uid"]=1
operation_parameters_minimum_occurences["setUserGroupPrivileges:::data"]=1
operation_parameters_minimum_occurences["addHandleGroup:::hndl"]=1
operation_parameters_minimum_occurences["addHandleGroup:::gid"]=1
operation_parameters_minimum_occurences["addHandleUser:::hndl"]=1
operation_parameters_minimum_occurences["addHandleUser:::uid"]=1
operation_parameters_minimum_occurences["getEffectiveHandleGroup:::hndl"]=1
operation_parameters_minimum_occurences["getEffectiveHandleGroup:::gid"]=1
operation_parameters_minimum_occurences["getEffectiveHandleUser:::hndl"]=1
operation_parameters_minimum_occurences["getEffectiveHandleUser:::uid"]=1
operation_parameters_minimum_occurences["getHandle:::hndl"]=1
operation_parameters_minimum_occurences["getHandleGroup:::hndl"]=1
operation_parameters_minimum_occurences["getHandleGroup:::gid"]=1
operation_parameters_minimum_occurences["getHandleUser:::hndl"]=1
operation_parameters_minimum_occurences["getHandleUser:::uid"]=1
operation_parameters_minimum_occurences["handleServiceRegisterHandle:::handleRegistrationRequest"]=1
operation_parameters_minimum_occurences["handleUpdate:::hndl"]=1
operation_parameters_minimum_occurences["handleUpdate:::handle"]=1
operation_parameters_minimum_occurences["listEffectiveHandleGroupPrivileges:::hndl"]=1
operation_parameters_minimum_occurences["listEffectiveHandleGroupPrivileges:::gid"]=1
operation_parameters_minimum_occurences["listEffectiveHandleGroups:::hndl"]=1
operation_parameters_minimum_occurences["listEffectiveHandleUserPrivileges:::hndl"]=1
operation_parameters_minimum_occurences["listEffectiveHandleUserPrivileges:::uid"]=1
operation_parameters_minimum_occurences["listEffectiveHandleUsers:::hndl"]=1
operation_parameters_minimum_occurences["listHandleGroupPrivileges:::hndl"]=1
operation_parameters_minimum_occurences["listHandleGroupPrivileges:::gid"]=1
operation_parameters_minimum_occurences["listHandleGroups:::hndl"]=1
operation_parameters_minimum_occurences["listHandleUserPrivileges:::hndl"]=1
operation_parameters_minimum_occurences["listHandleUserPrivileges:::uid"]=1
operation_parameters_minimum_occurences["listHandleUsers:::hndl"]=1
operation_parameters_minimum_occurences["removeHandle:::hndl"]=1
operation_parameters_minimum_occurences["removeHandleGroup:::hndl"]=1
operation_parameters_minimum_occurences["removeHandleGroup:::gid"]=1
operation_parameters_minimum_occurences["removeHandleUser:::hndl"]=1
operation_parameters_minimum_occurences["removeHandleUser:::uid"]=1
operation_parameters_minimum_occurences["setHandleGroupPrivileges:::hndl"]=1
operation_parameters_minimum_occurences["setHandleGroupPrivileges:::gid"]=1
operation_parameters_minimum_occurences["setHandleGroupPrivileges:::privileges"]=1
operation_parameters_minimum_occurences["setHandleUserPrivileges:::hndl"]=1
operation_parameters_minimum_occurences["setHandleUserPrivileges:::uid"]=1
operation_parameters_minimum_occurences["setHandleUserPrivileges:::privileges"]=1
operation_parameters_minimum_occurences["addHandleService:::handleService"]=1
operation_parameters_minimum_occurences["addHandleServiceGroup:::id"]=1
operation_parameters_minimum_occurences["addHandleServiceGroup:::gid"]=1
operation_parameters_minimum_occurences["addHandleServiceUser:::id"]=1
operation_parameters_minimum_occurences["addHandleServiceUser:::uid"]=1
operation_parameters_minimum_occurences["getEffectiveHandleServiceGroup:::id"]=1
operation_parameters_minimum_occurences["getEffectiveHandleServiceGroup:::gid"]=1
operation_parameters_minimum_occurences["getEffectiveHandleServiceGroupPrivileges:::id"]=1
operation_parameters_minimum_occurences["getEffectiveHandleServiceGroupPrivileges:::gid"]=1
operation_parameters_minimum_occurences["getEffectiveHandleServiceUser:::id"]=1
operation_parameters_minimum_occurences["getEffectiveHandleServiceUser:::uid"]=1
operation_parameters_minimum_occurences["getHandleService:::id"]=1
operation_parameters_minimum_occurences["getHandleServiceGroup:::id"]=1
operation_parameters_minimum_occurences["getHandleServiceGroup:::gid"]=1
operation_parameters_minimum_occurences["getHandleServiceHandle:::id"]=1
operation_parameters_minimum_occurences["getHandleServiceHandle:::hid"]=1
operation_parameters_minimum_occurences["getHandleServiceUser:::id"]=1
operation_parameters_minimum_occurences["getHandleServiceUser:::uid"]=1
operation_parameters_minimum_occurences["getHandleServiceUserPrivileges:::id"]=1
operation_parameters_minimum_occurences["getHandleServiceUserPrivileges:::uid"]=1
operation_parameters_minimum_occurences["handleServiceUpdate:::id"]=1
operation_parameters_minimum_occurences["handleServiceUpdate:::handleService"]=1
operation_parameters_minimum_occurences["listEffectiveHandleServiceGroups:::id"]=1
operation_parameters_minimum_occurences["listEffectiveHandleServiceUserPrivileges:::id"]=1
operation_parameters_minimum_occurences["listEffectiveHandleServiceUserPrivileges:::uid"]=1
operation_parameters_minimum_occurences["listEffectiveHandleServiceUsers:::id"]=1
operation_parameters_minimum_occurences["listHandleServiceGroupPrivileges:::id"]=1
operation_parameters_minimum_occurences["listHandleServiceGroupPrivileges:::gid"]=1
operation_parameters_minimum_occurences["listHandleServiceGroups:::id"]=1
operation_parameters_minimum_occurences["listHandleServiceUsers:::id"]=1
operation_parameters_minimum_occurences["listHandleserviceHandles:::id"]=1
operation_parameters_minimum_occurences["removeHandleService:::id"]=1
operation_parameters_minimum_occurences["removeHandleServiceGroup:::id"]=1
operation_parameters_minimum_occurences["removeHandleServiceGroup:::gid"]=1
operation_parameters_minimum_occurences["removeHandleServiceUser:::id"]=1
operation_parameters_minimum_occurences["removeHandleServiceUser:::uid"]=1
operation_parameters_minimum_occurences["setHandleServiceGroupPrivileges:::id"]=1
operation_parameters_minimum_occurences["setHandleServiceGroupPrivileges:::gid"]=1
operation_parameters_minimum_occurences["setHandleServiceGroupPrivileges:::privileges"]=1
operation_parameters_minimum_occurences["setHandleServiceUserPrivileges:::id"]=1
operation_parameters_minimum_occurences["setHandleServiceUserPrivileges:::uid"]=1
operation_parameters_minimum_occurences["setHandleServiceUserPrivileges:::privileges"]=1
operation_parameters_minimum_occurences["checkMyPorts:::ports"]=0
operation_parameters_minimum_occurences["getEffectiveProviderGroup:::pid"]=1
operation_parameters_minimum_occurences["getEffectiveProviderGroup:::gid"]=1
operation_parameters_minimum_occurences["getEffectiveProviderUser:::pid"]=1
operation_parameters_minimum_occurences["getEffectiveProviderUser:::uid"]=1
operation_parameters_minimum_occurences["getProviderDetails:::pid"]=1
operation_parameters_minimum_occurences["getProviderSpace:::pid"]=1
operation_parameters_minimum_occurences["getProviderSpace:::sid"]=1
operation_parameters_minimum_occurences["getSupportedSpace:::sid"]=1
operation_parameters_minimum_occurences["listEffectiveProviderGroups:::pid"]=1
operation_parameters_minimum_occurences["listEffectiveProviderUsers:::pid"]=1
operation_parameters_minimum_occurences["listProviderSpaces:::pid"]=1
operation_parameters_minimum_occurences["mapIdpGroup:::data"]=1
operation_parameters_minimum_occurences["modifyProvider:::data"]=1
operation_parameters_minimum_occurences["modifySupportedSpace:::sid"]=1
operation_parameters_minimum_occurences["providerSpaceSupport:::token"]=0
operation_parameters_minimum_occurences["registerProvider:::data"]=1
operation_parameters_minimum_occurences["removeProvider:::pid"]=1
operation_parameters_minimum_occurences["removeSpaceSupport:::sid"]=1
operation_parameters_minimum_occurences["verifyProviderIdentity:::data"]=1
operation_parameters_minimum_occurences["createShare:::data"]=1
operation_parameters_minimum_occurences["getShare:::id"]=1
operation_parameters_minimum_occurences["modifyShare:::id"]=1
operation_parameters_minimum_occurences["modifyShare:::data"]=1
operation_parameters_minimum_occurences["removeShare:::id"]=1
operation_parameters_minimum_occurences["addGroupToSpace:::id"]=1
operation_parameters_minimum_occurences["addGroupToSpace:::gid"]=1
operation_parameters_minimum_occurences["addGroupToSpace:::privileges"]=0
operation_parameters_minimum_occurences["addUserToSpace:::id"]=1
operation_parameters_minimum_occurences["addUserToSpace:::uid"]=1
operation_parameters_minimum_occurences["addUserToSpace:::privileges"]=0
operation_parameters_minimum_occurences["createSpace:::name"]=0
operation_parameters_minimum_occurences["createSpaceGroupToken:::id"]=1
operation_parameters_minimum_occurences["createSpaceSupportToken:::id"]=1
operation_parameters_minimum_occurences["createSpaceUserInviteToken:::id"]=1
operation_parameters_minimum_occurences["getEffectiveSpaceGroup:::id"]=1
operation_parameters_minimum_occurences["getEffectiveSpaceGroup:::gid"]=1
operation_parameters_minimum_occurences["getEffectiveSpaceUser:::id"]=1
operation_parameters_minimum_occurences["getEffectiveSpaceUser:::uid"]=1
operation_parameters_minimum_occurences["getSpace:::id"]=1
operation_parameters_minimum_occurences["getSpaceGroup:::id"]=1
operation_parameters_minimum_occurences["getSpaceGroup:::gid"]=1
operation_parameters_minimum_occurences["getSpaceProvider:::id"]=1
operation_parameters_minimum_occurences["getSpaceProvider:::pid"]=1
operation_parameters_minimum_occurences["getSpaceShare:::id"]=1
operation_parameters_minimum_occurences["getSpaceShare:::sid"]=1
operation_parameters_minimum_occurences["getSpaceUser:::id"]=1
operation_parameters_minimum_occurences["getSpaceUser:::uid"]=1
operation_parameters_minimum_occurences["listEffectiveSpaceGroupPrivileges:::id"]=1
operation_parameters_minimum_occurences["listEffectiveSpaceGroupPrivileges:::gid"]=1
operation_parameters_minimum_occurences["listEffectiveSpaceGroups:::id"]=1
operation_parameters_minimum_occurences["listEffectiveSpaceUserPrivileges:::id"]=1
operation_parameters_minimum_occurences["listEffectiveSpaceUserPrivileges:::uid"]=1
operation_parameters_minimum_occurences["listEffectiveSpaceUsers:::id"]=1
operation_parameters_minimum_occurences["listSpaceGroupPrivileges:::id"]=1
operation_parameters_minimum_occurences["listSpaceGroupPrivileges:::gid"]=1
operation_parameters_minimum_occurences["listSpaceGroups:::id"]=1
operation_parameters_minimum_occurences["listSpaceProviders:::id"]=1
operation_parameters_minimum_occurences["listSpaceShares:::id"]=1
operation_parameters_minimum_occurences["listSpaceUserPrivileges:::id"]=1
operation_parameters_minimum_occurences["listSpaceUserPrivileges:::uid"]=1
operation_parameters_minimum_occurences["listSpaceUsers:::id"]=1
operation_parameters_minimum_occurences["modifySpace:::id"]=1
operation_parameters_minimum_occurences["modifySpace:::data"]=1
operation_parameters_minimum_occurences["removeProviderSupportingSpace:::id"]=1
operation_parameters_minimum_occurences["removeProviderSupportingSpace:::pid"]=1
operation_parameters_minimum_occurences["removeSpace:::id"]=1
operation_parameters_minimum_occurences["removeSpaceGroup:::id"]=1
operation_parameters_minimum_occurences["removeSpaceGroup:::gid"]=1
operation_parameters_minimum_occurences["removeSpaceUser:::id"]=1
operation_parameters_minimum_occurences["removeSpaceUser:::uid"]=1
operation_parameters_minimum_occurences["setSpaceGroupPrivileges:::id"]=1
operation_parameters_minimum_occurences["setSpaceGroupPrivileges:::gid"]=1
operation_parameters_minimum_occurences["setSpaceGroupPrivileges:::data"]=0
operation_parameters_minimum_occurences["setSpaceUserPrivileges:::id"]=1
operation_parameters_minimum_occurences["setSpaceUserPrivileges:::uid"]=1
operation_parameters_minimum_occurences["setSpaceUserPrivileges:::data"]=1
operation_parameters_minimum_occurences["addUserHandleService:::handleService"]=1
operation_parameters_minimum_occurences["authorizeUser:::data"]=1
operation_parameters_minimum_occurences["createGroupForUser:::group"]=1
operation_parameters_minimum_occurences["createUserHandle:::handle"]=1
operation_parameters_minimum_occurences["createUserSpace:::space"]=1
operation_parameters_minimum_occurences["getEffectiveUserProvider:::pid"]=1
operation_parameters_minimum_occurences["getEffectiveUserSpace:::sid"]=1
operation_parameters_minimum_occurences["getUser:::id"]=1
operation_parameters_minimum_occurences["getUserEffectiveGroup:::gid"]=1
operation_parameters_minimum_occurences["getUserEffectiveHandle:::hid"]=1
operation_parameters_minimum_occurences["getUserEffectiveHandleService:::hsid"]=1
operation_parameters_minimum_occurences["getUserGroup:::gid"]=1
operation_parameters_minimum_occurences["getUserHandle:::hid"]=1
operation_parameters_minimum_occurences["getUserHandleService:::hsid"]=1
operation_parameters_minimum_occurences["getUserSpace:::sid"]=1
operation_parameters_minimum_occurences["getUserSpaceAlias:::sid"]=1
operation_parameters_minimum_occurences["joinGroup:::groupinvitetoken"]=1
operation_parameters_minimum_occurences["joinSpace:::spaceinvitetoken"]=1
operation_parameters_minimum_occurences["leaveGroup:::gid"]=1
operation_parameters_minimum_occurences["listUserOnezoneEffectivePrivileges:::id"]=1
operation_parameters_minimum_occurences["listUserOnezonePrivileges:::id"]=1
operation_parameters_minimum_occurences["modifyCurrentUser:::data"]=1
operation_parameters_minimum_occurences["removeClientToken:::tid"]=1
operation_parameters_minimum_occurences["removeUser:::id"]=1
operation_parameters_minimum_occurences["removeUserHandle:::hid"]=1
operation_parameters_minimum_occurences["removeUserHandleService:::hsid"]=1
operation_parameters_minimum_occurences["removeUserOnezonePrivileges:::id"]=1
operation_parameters_minimum_occurences["removeUserSpace:::sid"]=1
operation_parameters_minimum_occurences["removeUserSpaceAlias:::sid"]=1
operation_parameters_minimum_occurences["setCurrentUserPrivileges:::data"]=0
operation_parameters_minimum_occurences["setDefaultProvider:::defaultprovider"]=1
operation_parameters_minimum_occurences["setDefaultSpace:::defaultspace"]=1
operation_parameters_minimum_occurences["setUserOnezonePrivileges:::id"]=1
operation_parameters_minimum_occurences["setUserOnezonePrivileges:::data"]=0
operation_parameters_minimum_occurences["setUserSpaceAlias:::sid"]=1
operation_parameters_minimum_occurences["setUserSpaceAlias:::data"]=1

##
# This array stores the maximum number of allowed occurences for parameter
# 1 - single value
# 2 - 2 values
# N - N values
# 0 - unlimited
declare -A operation_parameters_maximum_occurences
operation_parameters_maximum_occurences["addChildGroup:::id"]=0
operation_parameters_maximum_occurences["addChildGroup:::cid"]=0
operation_parameters_maximum_occurences["addGroupHandleService:::handleService"]=0
operation_parameters_maximum_occurences["addGroupHandleService:::id"]=0
operation_parameters_maximum_occurences["addGroupUser:::id"]=0
operation_parameters_maximum_occurences["addGroupUser:::uid"]=0
operation_parameters_maximum_occurences["addGroupUser:::privileges"]=0
operation_parameters_maximum_occurences["createChildGroupToken:::id"]=0
operation_parameters_maximum_occurences["createGroup:::data"]=0
operation_parameters_maximum_occurences["createGroupForGroup:::id"]=0
operation_parameters_maximum_occurences["createGroupForGroup:::group"]=0
operation_parameters_maximum_occurences["createGroupHandle:::handle"]=0
operation_parameters_maximum_occurences["createGroupHandle:::id"]=0
operation_parameters_maximum_occurences["createSpaceForGroup:::id"]=0
operation_parameters_maximum_occurences["createSpaceForGroup:::spaceName"]=0
operation_parameters_maximum_occurences["createUserGroupInviteToken:::id"]=0
operation_parameters_maximum_occurences["getChildGroup:::id"]=0
operation_parameters_maximum_occurences["getChildGroup:::cid"]=0
operation_parameters_maximum_occurences["getEffectiveChildGroup:::id"]=0
operation_parameters_maximum_occurences["getEffectiveChildGroup:::cid"]=0
operation_parameters_maximum_occurences["getEffectiveChildrenGroups:::id"]=0
operation_parameters_maximum_occurences["getEffectiveGroupHandle:::id"]=0
operation_parameters_maximum_occurences["getEffectiveGroupHandle:::hid"]=0
operation_parameters_maximum_occurences["getEffectiveGroupProvider:::id"]=0
operation_parameters_maximum_occurences["getEffectiveGroupProvider:::pid"]=0
operation_parameters_maximum_occurences["getEffectiveGroupSpace:::id"]=0
operation_parameters_maximum_occurences["getEffectiveGroupSpace:::sid"]=0
operation_parameters_maximum_occurences["getEffectiveGroupUser:::id"]=0
operation_parameters_maximum_occurences["getEffectiveGroupUser:::uid"]=0
operation_parameters_maximum_occurences["getEffectiveParentGroup:::id"]=0
operation_parameters_maximum_occurences["getEffectiveParentGroup:::pid"]=0
operation_parameters_maximum_occurences["getGroup:::id"]=0
operation_parameters_maximum_occurences["getGroupEffectiveHandleService:::id"]=0
operation_parameters_maximum_occurences["getGroupEffectiveHandleService:::hsid"]=0
operation_parameters_maximum_occurences["getGroupHandle:::id"]=0
operation_parameters_maximum_occurences["getGroupHandle:::hid"]=0
operation_parameters_maximum_occurences["getGroupHandleService:::id"]=0
operation_parameters_maximum_occurences["getGroupHandleService:::hsid"]=0
operation_parameters_maximum_occurences["getGroupSpace:::id"]=0
operation_parameters_maximum_occurences["getGroupSpace:::sid"]=0
operation_parameters_maximum_occurences["getGroupUser:::id"]=0
operation_parameters_maximum_occurences["getGroupUser:::uid"]=0
operation_parameters_maximum_occurences["getParentGroup:::id"]=0
operation_parameters_maximum_occurences["getParentGroup:::pid"]=0
operation_parameters_maximum_occurences["groupJoinSpace:::id"]=0
operation_parameters_maximum_occurences["groupJoinSpace:::data"]=0
operation_parameters_maximum_occurences["joinParentGroup:::id"]=0
operation_parameters_maximum_occurences["joinParentGroup:::data"]=0
operation_parameters_maximum_occurences["leaveParentGroup:::id"]=0
operation_parameters_maximum_occurences["leaveParentGroup:::pid"]=0
operation_parameters_maximum_occurences["listChildGroupPrivileges:::id"]=0
operation_parameters_maximum_occurences["listChildGroupPrivileges:::cid"]=0
operation_parameters_maximum_occurences["listChildGroups:::id"]=0
operation_parameters_maximum_occurences["listEffectiveChildGroupPrivileges:::id"]=0
operation_parameters_maximum_occurences["listEffectiveChildGroupPrivileges:::cid"]=0
operation_parameters_maximum_occurences["listEffectiveGroupHandleServices:::id"]=0
operation_parameters_maximum_occurences["listEffectiveGroupHandles:::id"]=0
operation_parameters_maximum_occurences["listEffectiveGroupPrivileges:::id"]=0
operation_parameters_maximum_occurences["listEffectiveGroupProviders:::id"]=0
operation_parameters_maximum_occurences["listEffectiveGroupSpaces:::id"]=0
operation_parameters_maximum_occurences["listEffectiveGroupUsers:::id"]=0
operation_parameters_maximum_occurences["listEffectiveParentGroups:::id"]=0
operation_parameters_maximum_occurences["listGroupHandleServices:::id"]=0
operation_parameters_maximum_occurences["listGroupHandles:::id"]=0
operation_parameters_maximum_occurences["listGroupOnezonePrivileges:::id"]=0
operation_parameters_maximum_occurences["listGroupSpaces:::id"]=0
operation_parameters_maximum_occurences["listGroupUsers:::id"]=0
operation_parameters_maximum_occurences["listGroupsUserPrivileges:::id"]=0
operation_parameters_maximum_occurences["listGroupsUserPrivileges:::uid"]=0
operation_parameters_maximum_occurences["listParentGroups:::id"]=0
operation_parameters_maximum_occurences["listUserGroupPrivileges:::id"]=0
operation_parameters_maximum_occurences["listUserGroupPrivileges:::uid"]=0
operation_parameters_maximum_occurences["modifyGroup:::id"]=0
operation_parameters_maximum_occurences["modifyGroup:::data"]=0
operation_parameters_maximum_occurences["removeChildGroup:::id"]=0
operation_parameters_maximum_occurences["removeChildGroup:::cid"]=0
operation_parameters_maximum_occurences["removeGroup:::id"]=0
operation_parameters_maximum_occurences["removeGroupFromSpace:::id"]=0
operation_parameters_maximum_occurences["removeGroupFromSpace:::sid"]=0
operation_parameters_maximum_occurences["removeGroupHandle:::id"]=0
operation_parameters_maximum_occurences["removeGroupHandle:::hid"]=0
operation_parameters_maximum_occurences["removeGroupHandleService:::id"]=0
operation_parameters_maximum_occurences["removeGroupHandleService:::hsid"]=0
operation_parameters_maximum_occurences["removeGroupOnezonePrivileges:::id"]=0
operation_parameters_maximum_occurences["removeGroupUser:::id"]=0
operation_parameters_maximum_occurences["removeGroupUser:::uid"]=0
operation_parameters_maximum_occurences["setChildGroupPrivileges:::id"]=0
operation_parameters_maximum_occurences["setChildGroupPrivileges:::cid"]=0
operation_parameters_maximum_occurences["setChildGroupPrivileges:::data"]=0
operation_parameters_maximum_occurences["setGroupOnezonePrivileges:::id"]=0
operation_parameters_maximum_occurences["setGroupOnezonePrivileges:::data"]=0
operation_parameters_maximum_occurences["setUserGroupPrivileges:::id"]=0
operation_parameters_maximum_occurences["setUserGroupPrivileges:::uid"]=0
operation_parameters_maximum_occurences["setUserGroupPrivileges:::data"]=0
operation_parameters_maximum_occurences["addHandleGroup:::hndl"]=0
operation_parameters_maximum_occurences["addHandleGroup:::gid"]=0
operation_parameters_maximum_occurences["addHandleUser:::hndl"]=0
operation_parameters_maximum_occurences["addHandleUser:::uid"]=0
operation_parameters_maximum_occurences["getEffectiveHandleGroup:::hndl"]=0
operation_parameters_maximum_occurences["getEffectiveHandleGroup:::gid"]=0
operation_parameters_maximum_occurences["getEffectiveHandleUser:::hndl"]=0
operation_parameters_maximum_occurences["getEffectiveHandleUser:::uid"]=0
operation_parameters_maximum_occurences["getHandle:::hndl"]=0
operation_parameters_maximum_occurences["getHandleGroup:::hndl"]=0
operation_parameters_maximum_occurences["getHandleGroup:::gid"]=0
operation_parameters_maximum_occurences["getHandleUser:::hndl"]=0
operation_parameters_maximum_occurences["getHandleUser:::uid"]=0
operation_parameters_maximum_occurences["handleServiceRegisterHandle:::handleRegistrationRequest"]=0
operation_parameters_maximum_occurences["handleUpdate:::hndl"]=0
operation_parameters_maximum_occurences["handleUpdate:::handle"]=0
operation_parameters_maximum_occurences["listEffectiveHandleGroupPrivileges:::hndl"]=0
operation_parameters_maximum_occurences["listEffectiveHandleGroupPrivileges:::gid"]=0
operation_parameters_maximum_occurences["listEffectiveHandleGroups:::hndl"]=0
operation_parameters_maximum_occurences["listEffectiveHandleUserPrivileges:::hndl"]=0
operation_parameters_maximum_occurences["listEffectiveHandleUserPrivileges:::uid"]=0
operation_parameters_maximum_occurences["listEffectiveHandleUsers:::hndl"]=0
operation_parameters_maximum_occurences["listHandleGroupPrivileges:::hndl"]=0
operation_parameters_maximum_occurences["listHandleGroupPrivileges:::gid"]=0
operation_parameters_maximum_occurences["listHandleGroups:::hndl"]=0
operation_parameters_maximum_occurences["listHandleUserPrivileges:::hndl"]=0
operation_parameters_maximum_occurences["listHandleUserPrivileges:::uid"]=0
operation_parameters_maximum_occurences["listHandleUsers:::hndl"]=0
operation_parameters_maximum_occurences["removeHandle:::hndl"]=0
operation_parameters_maximum_occurences["removeHandleGroup:::hndl"]=0
operation_parameters_maximum_occurences["removeHandleGroup:::gid"]=0
operation_parameters_maximum_occurences["removeHandleUser:::hndl"]=0
operation_parameters_maximum_occurences["removeHandleUser:::uid"]=0
operation_parameters_maximum_occurences["setHandleGroupPrivileges:::hndl"]=0
operation_parameters_maximum_occurences["setHandleGroupPrivileges:::gid"]=0
operation_parameters_maximum_occurences["setHandleGroupPrivileges:::privileges"]=0
operation_parameters_maximum_occurences["setHandleUserPrivileges:::hndl"]=0
operation_parameters_maximum_occurences["setHandleUserPrivileges:::uid"]=0
operation_parameters_maximum_occurences["setHandleUserPrivileges:::privileges"]=0
operation_parameters_maximum_occurences["addHandleService:::handleService"]=0
operation_parameters_maximum_occurences["addHandleServiceGroup:::id"]=0
operation_parameters_maximum_occurences["addHandleServiceGroup:::gid"]=0
operation_parameters_maximum_occurences["addHandleServiceUser:::id"]=0
operation_parameters_maximum_occurences["addHandleServiceUser:::uid"]=0
operation_parameters_maximum_occurences["getEffectiveHandleServiceGroup:::id"]=0
operation_parameters_maximum_occurences["getEffectiveHandleServiceGroup:::gid"]=0
operation_parameters_maximum_occurences["getEffectiveHandleServiceGroupPrivileges:::id"]=0
operation_parameters_maximum_occurences["getEffectiveHandleServiceGroupPrivileges:::gid"]=0
operation_parameters_maximum_occurences["getEffectiveHandleServiceUser:::id"]=0
operation_parameters_maximum_occurences["getEffectiveHandleServiceUser:::uid"]=0
operation_parameters_maximum_occurences["getHandleService:::id"]=0
operation_parameters_maximum_occurences["getHandleServiceGroup:::id"]=0
operation_parameters_maximum_occurences["getHandleServiceGroup:::gid"]=0
operation_parameters_maximum_occurences["getHandleServiceHandle:::id"]=0
operation_parameters_maximum_occurences["getHandleServiceHandle:::hid"]=0
operation_parameters_maximum_occurences["getHandleServiceUser:::id"]=0
operation_parameters_maximum_occurences["getHandleServiceUser:::uid"]=0
operation_parameters_maximum_occurences["getHandleServiceUserPrivileges:::id"]=0
operation_parameters_maximum_occurences["getHandleServiceUserPrivileges:::uid"]=0
operation_parameters_maximum_occurences["handleServiceUpdate:::id"]=0
operation_parameters_maximum_occurences["handleServiceUpdate:::handleService"]=0
operation_parameters_maximum_occurences["listEffectiveHandleServiceGroups:::id"]=0
operation_parameters_maximum_occurences["listEffectiveHandleServiceUserPrivileges:::id"]=0
operation_parameters_maximum_occurences["listEffectiveHandleServiceUserPrivileges:::uid"]=0
operation_parameters_maximum_occurences["listEffectiveHandleServiceUsers:::id"]=0
operation_parameters_maximum_occurences["listHandleServiceGroupPrivileges:::id"]=0
operation_parameters_maximum_occurences["listHandleServiceGroupPrivileges:::gid"]=0
operation_parameters_maximum_occurences["listHandleServiceGroups:::id"]=0
operation_parameters_maximum_occurences["listHandleServiceUsers:::id"]=0
operation_parameters_maximum_occurences["listHandleserviceHandles:::id"]=0
operation_parameters_maximum_occurences["removeHandleService:::id"]=0
operation_parameters_maximum_occurences["removeHandleServiceGroup:::id"]=0
operation_parameters_maximum_occurences["removeHandleServiceGroup:::gid"]=0
operation_parameters_maximum_occurences["removeHandleServiceUser:::id"]=0
operation_parameters_maximum_occurences["removeHandleServiceUser:::uid"]=0
operation_parameters_maximum_occurences["setHandleServiceGroupPrivileges:::id"]=0
operation_parameters_maximum_occurences["setHandleServiceGroupPrivileges:::gid"]=0
operation_parameters_maximum_occurences["setHandleServiceGroupPrivileges:::privileges"]=0
operation_parameters_maximum_occurences["setHandleServiceUserPrivileges:::id"]=0
operation_parameters_maximum_occurences["setHandleServiceUserPrivileges:::uid"]=0
operation_parameters_maximum_occurences["setHandleServiceUserPrivileges:::privileges"]=0
operation_parameters_maximum_occurences["checkMyPorts:::ports"]=0
operation_parameters_maximum_occurences["getEffectiveProviderGroup:::pid"]=0
operation_parameters_maximum_occurences["getEffectiveProviderGroup:::gid"]=0
operation_parameters_maximum_occurences["getEffectiveProviderUser:::pid"]=0
operation_parameters_maximum_occurences["getEffectiveProviderUser:::uid"]=0
operation_parameters_maximum_occurences["getProviderDetails:::pid"]=0
operation_parameters_maximum_occurences["getProviderSpace:::pid"]=0
operation_parameters_maximum_occurences["getProviderSpace:::sid"]=0
operation_parameters_maximum_occurences["getSupportedSpace:::sid"]=0
operation_parameters_maximum_occurences["listEffectiveProviderGroups:::pid"]=0
operation_parameters_maximum_occurences["listEffectiveProviderUsers:::pid"]=0
operation_parameters_maximum_occurences["listProviderSpaces:::pid"]=0
operation_parameters_maximum_occurences["mapIdpGroup:::data"]=0
operation_parameters_maximum_occurences["modifyProvider:::data"]=0
operation_parameters_maximum_occurences["modifySupportedSpace:::sid"]=0
operation_parameters_maximum_occurences["providerSpaceSupport:::token"]=0
operation_parameters_maximum_occurences["registerProvider:::data"]=0
operation_parameters_maximum_occurences["removeProvider:::pid"]=0
operation_parameters_maximum_occurences["removeSpaceSupport:::sid"]=0
operation_parameters_maximum_occurences["verifyProviderIdentity:::data"]=0
operation_parameters_maximum_occurences["createShare:::data"]=0
operation_parameters_maximum_occurences["getShare:::id"]=0
operation_parameters_maximum_occurences["modifyShare:::id"]=0
operation_parameters_maximum_occurences["modifyShare:::data"]=0
operation_parameters_maximum_occurences["removeShare:::id"]=0
operation_parameters_maximum_occurences["addGroupToSpace:::id"]=0
operation_parameters_maximum_occurences["addGroupToSpace:::gid"]=0
operation_parameters_maximum_occurences["addGroupToSpace:::privileges"]=0
operation_parameters_maximum_occurences["addUserToSpace:::id"]=0
operation_parameters_maximum_occurences["addUserToSpace:::uid"]=0
operation_parameters_maximum_occurences["addUserToSpace:::privileges"]=0
operation_parameters_maximum_occurences["createSpace:::name"]=0
operation_parameters_maximum_occurences["createSpaceGroupToken:::id"]=0
operation_parameters_maximum_occurences["createSpaceSupportToken:::id"]=0
operation_parameters_maximum_occurences["createSpaceUserInviteToken:::id"]=0
operation_parameters_maximum_occurences["getEffectiveSpaceGroup:::id"]=0
operation_parameters_maximum_occurences["getEffectiveSpaceGroup:::gid"]=0
operation_parameters_maximum_occurences["getEffectiveSpaceUser:::id"]=0
operation_parameters_maximum_occurences["getEffectiveSpaceUser:::uid"]=0
operation_parameters_maximum_occurences["getSpace:::id"]=0
operation_parameters_maximum_occurences["getSpaceGroup:::id"]=0
operation_parameters_maximum_occurences["getSpaceGroup:::gid"]=0
operation_parameters_maximum_occurences["getSpaceProvider:::id"]=0
operation_parameters_maximum_occurences["getSpaceProvider:::pid"]=0
operation_parameters_maximum_occurences["getSpaceShare:::id"]=0
operation_parameters_maximum_occurences["getSpaceShare:::sid"]=0
operation_parameters_maximum_occurences["getSpaceUser:::id"]=0
operation_parameters_maximum_occurences["getSpaceUser:::uid"]=0
operation_parameters_maximum_occurences["listEffectiveSpaceGroupPrivileges:::id"]=0
operation_parameters_maximum_occurences["listEffectiveSpaceGroupPrivileges:::gid"]=0
operation_parameters_maximum_occurences["listEffectiveSpaceGroups:::id"]=0
operation_parameters_maximum_occurences["listEffectiveSpaceUserPrivileges:::id"]=0
operation_parameters_maximum_occurences["listEffectiveSpaceUserPrivileges:::uid"]=0
operation_parameters_maximum_occurences["listEffectiveSpaceUsers:::id"]=0
operation_parameters_maximum_occurences["listSpaceGroupPrivileges:::id"]=0
operation_parameters_maximum_occurences["listSpaceGroupPrivileges:::gid"]=0
operation_parameters_maximum_occurences["listSpaceGroups:::id"]=0
operation_parameters_maximum_occurences["listSpaceProviders:::id"]=0
operation_parameters_maximum_occurences["listSpaceShares:::id"]=0
operation_parameters_maximum_occurences["listSpaceUserPrivileges:::id"]=0
operation_parameters_maximum_occurences["listSpaceUserPrivileges:::uid"]=0
operation_parameters_maximum_occurences["listSpaceUsers:::id"]=0
operation_parameters_maximum_occurences["modifySpace:::id"]=0
operation_parameters_maximum_occurences["modifySpace:::data"]=0
operation_parameters_maximum_occurences["removeProviderSupportingSpace:::id"]=0
operation_parameters_maximum_occurences["removeProviderSupportingSpace:::pid"]=0
operation_parameters_maximum_occurences["removeSpace:::id"]=0
operation_parameters_maximum_occurences["removeSpaceGroup:::id"]=0
operation_parameters_maximum_occurences["removeSpaceGroup:::gid"]=0
operation_parameters_maximum_occurences["removeSpaceUser:::id"]=0
operation_parameters_maximum_occurences["removeSpaceUser:::uid"]=0
operation_parameters_maximum_occurences["setSpaceGroupPrivileges:::id"]=0
operation_parameters_maximum_occurences["setSpaceGroupPrivileges:::gid"]=0
operation_parameters_maximum_occurences["setSpaceGroupPrivileges:::data"]=0
operation_parameters_maximum_occurences["setSpaceUserPrivileges:::id"]=0
operation_parameters_maximum_occurences["setSpaceUserPrivileges:::uid"]=0
operation_parameters_maximum_occurences["setSpaceUserPrivileges:::data"]=0
operation_parameters_maximum_occurences["addUserHandleService:::handleService"]=0
operation_parameters_maximum_occurences["authorizeUser:::data"]=0
operation_parameters_maximum_occurences["createGroupForUser:::group"]=0
operation_parameters_maximum_occurences["createUserHandle:::handle"]=0
operation_parameters_maximum_occurences["createUserSpace:::space"]=0
operation_parameters_maximum_occurences["getEffectiveUserProvider:::pid"]=0
operation_parameters_maximum_occurences["getEffectiveUserSpace:::sid"]=0
operation_parameters_maximum_occurences["getUser:::id"]=0
operation_parameters_maximum_occurences["getUserEffectiveGroup:::gid"]=0
operation_parameters_maximum_occurences["getUserEffectiveHandle:::hid"]=0
operation_parameters_maximum_occurences["getUserEffectiveHandleService:::hsid"]=0
operation_parameters_maximum_occurences["getUserGroup:::gid"]=0
operation_parameters_maximum_occurences["getUserHandle:::hid"]=0
operation_parameters_maximum_occurences["getUserHandleService:::hsid"]=0
operation_parameters_maximum_occurences["getUserSpace:::sid"]=0
operation_parameters_maximum_occurences["getUserSpaceAlias:::sid"]=0
operation_parameters_maximum_occurences["joinGroup:::groupinvitetoken"]=0
operation_parameters_maximum_occurences["joinSpace:::spaceinvitetoken"]=0
operation_parameters_maximum_occurences["leaveGroup:::gid"]=0
operation_parameters_maximum_occurences["listUserOnezoneEffectivePrivileges:::id"]=0
operation_parameters_maximum_occurences["listUserOnezonePrivileges:::id"]=0
operation_parameters_maximum_occurences["modifyCurrentUser:::data"]=0
operation_parameters_maximum_occurences["removeClientToken:::tid"]=0
operation_parameters_maximum_occurences["removeUser:::id"]=0
operation_parameters_maximum_occurences["removeUserHandle:::hid"]=0
operation_parameters_maximum_occurences["removeUserHandleService:::hsid"]=0
operation_parameters_maximum_occurences["removeUserOnezonePrivileges:::id"]=0
operation_parameters_maximum_occurences["removeUserSpace:::sid"]=0
operation_parameters_maximum_occurences["removeUserSpaceAlias:::sid"]=0
operation_parameters_maximum_occurences["setCurrentUserPrivileges:::data"]=0
operation_parameters_maximum_occurences["setDefaultProvider:::defaultprovider"]=0
operation_parameters_maximum_occurences["setDefaultSpace:::defaultspace"]=0
operation_parameters_maximum_occurences["setUserOnezonePrivileges:::id"]=0
operation_parameters_maximum_occurences["setUserOnezonePrivileges:::data"]=0
operation_parameters_maximum_occurences["setUserSpaceAlias:::sid"]=0
operation_parameters_maximum_occurences["setUserSpaceAlias:::data"]=0

##
# The type of collection for specifying multiple values for parameter:
# - multi, csv, ssv, tsv
declare -A operation_parameters_collection_type
operation_parameters_collection_type["addChildGroup:::id"]=""
operation_parameters_collection_type["addChildGroup:::cid"]=""
operation_parameters_collection_type["addGroupHandleService:::handleService"]=""
operation_parameters_collection_type["addGroupHandleService:::id"]=""
operation_parameters_collection_type["addGroupUser:::id"]=""
operation_parameters_collection_type["addGroupUser:::uid"]=""
operation_parameters_collection_type["addGroupUser:::privileges"]=""
operation_parameters_collection_type["createChildGroupToken:::id"]=""
operation_parameters_collection_type["createGroup:::data"]=""
operation_parameters_collection_type["createGroupForGroup:::id"]=""
operation_parameters_collection_type["createGroupForGroup:::group"]=""
operation_parameters_collection_type["createGroupHandle:::handle"]=""
operation_parameters_collection_type["createGroupHandle:::id"]=""
operation_parameters_collection_type["createSpaceForGroup:::id"]=""
operation_parameters_collection_type["createSpaceForGroup:::spaceName"]=""
operation_parameters_collection_type["createUserGroupInviteToken:::id"]=""
operation_parameters_collection_type["getChildGroup:::id"]=""
operation_parameters_collection_type["getChildGroup:::cid"]=""
operation_parameters_collection_type["getEffectiveChildGroup:::id"]=""
operation_parameters_collection_type["getEffectiveChildGroup:::cid"]=""
operation_parameters_collection_type["getEffectiveChildrenGroups:::id"]=""
operation_parameters_collection_type["getEffectiveGroupHandle:::id"]=""
operation_parameters_collection_type["getEffectiveGroupHandle:::hid"]=""
operation_parameters_collection_type["getEffectiveGroupProvider:::id"]=""
operation_parameters_collection_type["getEffectiveGroupProvider:::pid"]=""
operation_parameters_collection_type["getEffectiveGroupSpace:::id"]=""
operation_parameters_collection_type["getEffectiveGroupSpace:::sid"]=""
operation_parameters_collection_type["getEffectiveGroupUser:::id"]=""
operation_parameters_collection_type["getEffectiveGroupUser:::uid"]=""
operation_parameters_collection_type["getEffectiveParentGroup:::id"]=""
operation_parameters_collection_type["getEffectiveParentGroup:::pid"]=""
operation_parameters_collection_type["getGroup:::id"]=""
operation_parameters_collection_type["getGroupEffectiveHandleService:::id"]=""
operation_parameters_collection_type["getGroupEffectiveHandleService:::hsid"]=""
operation_parameters_collection_type["getGroupHandle:::id"]=""
operation_parameters_collection_type["getGroupHandle:::hid"]=""
operation_parameters_collection_type["getGroupHandleService:::id"]=""
operation_parameters_collection_type["getGroupHandleService:::hsid"]=""
operation_parameters_collection_type["getGroupSpace:::id"]=""
operation_parameters_collection_type["getGroupSpace:::sid"]=""
operation_parameters_collection_type["getGroupUser:::id"]=""
operation_parameters_collection_type["getGroupUser:::uid"]=""
operation_parameters_collection_type["getParentGroup:::id"]=""
operation_parameters_collection_type["getParentGroup:::pid"]=""
operation_parameters_collection_type["groupJoinSpace:::id"]=""
operation_parameters_collection_type["groupJoinSpace:::data"]=""
operation_parameters_collection_type["joinParentGroup:::id"]=""
operation_parameters_collection_type["joinParentGroup:::data"]=""
operation_parameters_collection_type["leaveParentGroup:::id"]=""
operation_parameters_collection_type["leaveParentGroup:::pid"]=""
operation_parameters_collection_type["listChildGroupPrivileges:::id"]=""
operation_parameters_collection_type["listChildGroupPrivileges:::cid"]=""
operation_parameters_collection_type["listChildGroups:::id"]=""
operation_parameters_collection_type["listEffectiveChildGroupPrivileges:::id"]=""
operation_parameters_collection_type["listEffectiveChildGroupPrivileges:::cid"]=""
operation_parameters_collection_type["listEffectiveGroupHandleServices:::id"]=""
operation_parameters_collection_type["listEffectiveGroupHandles:::id"]=""
operation_parameters_collection_type["listEffectiveGroupPrivileges:::id"]=""
operation_parameters_collection_type["listEffectiveGroupProviders:::id"]=""
operation_parameters_collection_type["listEffectiveGroupSpaces:::id"]=""
operation_parameters_collection_type["listEffectiveGroupUsers:::id"]=""
operation_parameters_collection_type["listEffectiveParentGroups:::id"]=""
operation_parameters_collection_type["listGroupHandleServices:::id"]=""
operation_parameters_collection_type["listGroupHandles:::id"]=""
operation_parameters_collection_type["listGroupOnezonePrivileges:::id"]=""
operation_parameters_collection_type["listGroupSpaces:::id"]=""
operation_parameters_collection_type["listGroupUsers:::id"]=""
operation_parameters_collection_type["listGroupsUserPrivileges:::id"]=""
operation_parameters_collection_type["listGroupsUserPrivileges:::uid"]=""
operation_parameters_collection_type["listParentGroups:::id"]=""
operation_parameters_collection_type["listUserGroupPrivileges:::id"]=""
operation_parameters_collection_type["listUserGroupPrivileges:::uid"]=""
operation_parameters_collection_type["modifyGroup:::id"]=""
operation_parameters_collection_type["modifyGroup:::data"]=""
operation_parameters_collection_type["removeChildGroup:::id"]=""
operation_parameters_collection_type["removeChildGroup:::cid"]=""
operation_parameters_collection_type["removeGroup:::id"]=""
operation_parameters_collection_type["removeGroupFromSpace:::id"]=""
operation_parameters_collection_type["removeGroupFromSpace:::sid"]=""
operation_parameters_collection_type["removeGroupHandle:::id"]=""
operation_parameters_collection_type["removeGroupHandle:::hid"]=""
operation_parameters_collection_type["removeGroupHandleService:::id"]=""
operation_parameters_collection_type["removeGroupHandleService:::hsid"]=""
operation_parameters_collection_type["removeGroupOnezonePrivileges:::id"]=""
operation_parameters_collection_type["removeGroupUser:::id"]=""
operation_parameters_collection_type["removeGroupUser:::uid"]=""
operation_parameters_collection_type["setChildGroupPrivileges:::id"]=""
operation_parameters_collection_type["setChildGroupPrivileges:::cid"]=""
operation_parameters_collection_type["setChildGroupPrivileges:::data"]=""
operation_parameters_collection_type["setGroupOnezonePrivileges:::id"]=""
operation_parameters_collection_type["setGroupOnezonePrivileges:::data"]=""
operation_parameters_collection_type["setUserGroupPrivileges:::id"]=""
operation_parameters_collection_type["setUserGroupPrivileges:::uid"]=""
operation_parameters_collection_type["setUserGroupPrivileges:::data"]=""
operation_parameters_collection_type["addHandleGroup:::hndl"]=""
operation_parameters_collection_type["addHandleGroup:::gid"]=""
operation_parameters_collection_type["addHandleUser:::hndl"]=""
operation_parameters_collection_type["addHandleUser:::uid"]=""
operation_parameters_collection_type["getEffectiveHandleGroup:::hndl"]=""
operation_parameters_collection_type["getEffectiveHandleGroup:::gid"]=""
operation_parameters_collection_type["getEffectiveHandleUser:::hndl"]=""
operation_parameters_collection_type["getEffectiveHandleUser:::uid"]=""
operation_parameters_collection_type["getHandle:::hndl"]=""
operation_parameters_collection_type["getHandleGroup:::hndl"]=""
operation_parameters_collection_type["getHandleGroup:::gid"]=""
operation_parameters_collection_type["getHandleUser:::hndl"]=""
operation_parameters_collection_type["getHandleUser:::uid"]=""
operation_parameters_collection_type["handleServiceRegisterHandle:::handleRegistrationRequest"]=""
operation_parameters_collection_type["handleUpdate:::hndl"]=""
operation_parameters_collection_type["handleUpdate:::handle"]=""
operation_parameters_collection_type["listEffectiveHandleGroupPrivileges:::hndl"]=""
operation_parameters_collection_type["listEffectiveHandleGroupPrivileges:::gid"]=""
operation_parameters_collection_type["listEffectiveHandleGroups:::hndl"]=""
operation_parameters_collection_type["listEffectiveHandleUserPrivileges:::hndl"]=""
operation_parameters_collection_type["listEffectiveHandleUserPrivileges:::uid"]=""
operation_parameters_collection_type["listEffectiveHandleUsers:::hndl"]=""
operation_parameters_collection_type["listHandleGroupPrivileges:::hndl"]=""
operation_parameters_collection_type["listHandleGroupPrivileges:::gid"]=""
operation_parameters_collection_type["listHandleGroups:::hndl"]=""
operation_parameters_collection_type["listHandleUserPrivileges:::hndl"]=""
operation_parameters_collection_type["listHandleUserPrivileges:::uid"]=""
operation_parameters_collection_type["listHandleUsers:::hndl"]=""
operation_parameters_collection_type["removeHandle:::hndl"]=""
operation_parameters_collection_type["removeHandleGroup:::hndl"]=""
operation_parameters_collection_type["removeHandleGroup:::gid"]=""
operation_parameters_collection_type["removeHandleUser:::hndl"]=""
operation_parameters_collection_type["removeHandleUser:::uid"]=""
operation_parameters_collection_type["setHandleGroupPrivileges:::hndl"]=""
operation_parameters_collection_type["setHandleGroupPrivileges:::gid"]=""
operation_parameters_collection_type["setHandleGroupPrivileges:::privileges"]=""
operation_parameters_collection_type["setHandleUserPrivileges:::hndl"]=""
operation_parameters_collection_type["setHandleUserPrivileges:::uid"]=""
operation_parameters_collection_type["setHandleUserPrivileges:::privileges"]=""
operation_parameters_collection_type["addHandleService:::handleService"]=""
operation_parameters_collection_type["addHandleServiceGroup:::id"]=""
operation_parameters_collection_type["addHandleServiceGroup:::gid"]=""
operation_parameters_collection_type["addHandleServiceUser:::id"]=""
operation_parameters_collection_type["addHandleServiceUser:::uid"]=""
operation_parameters_collection_type["getEffectiveHandleServiceGroup:::id"]=""
operation_parameters_collection_type["getEffectiveHandleServiceGroup:::gid"]=""
operation_parameters_collection_type["getEffectiveHandleServiceGroupPrivileges:::id"]=""
operation_parameters_collection_type["getEffectiveHandleServiceGroupPrivileges:::gid"]=""
operation_parameters_collection_type["getEffectiveHandleServiceUser:::id"]=""
operation_parameters_collection_type["getEffectiveHandleServiceUser:::uid"]=""
operation_parameters_collection_type["getHandleService:::id"]=""
operation_parameters_collection_type["getHandleServiceGroup:::id"]=""
operation_parameters_collection_type["getHandleServiceGroup:::gid"]=""
operation_parameters_collection_type["getHandleServiceHandle:::id"]=""
operation_parameters_collection_type["getHandleServiceHandle:::hid"]=""
operation_parameters_collection_type["getHandleServiceUser:::id"]=""
operation_parameters_collection_type["getHandleServiceUser:::uid"]=""
operation_parameters_collection_type["getHandleServiceUserPrivileges:::id"]=""
operation_parameters_collection_type["getHandleServiceUserPrivileges:::uid"]=""
operation_parameters_collection_type["handleServiceUpdate:::id"]=""
operation_parameters_collection_type["handleServiceUpdate:::handleService"]=""
operation_parameters_collection_type["listEffectiveHandleServiceGroups:::id"]=""
operation_parameters_collection_type["listEffectiveHandleServiceUserPrivileges:::id"]=""
operation_parameters_collection_type["listEffectiveHandleServiceUserPrivileges:::uid"]=""
operation_parameters_collection_type["listEffectiveHandleServiceUsers:::id"]=""
operation_parameters_collection_type["listHandleServiceGroupPrivileges:::id"]=""
operation_parameters_collection_type["listHandleServiceGroupPrivileges:::gid"]=""
operation_parameters_collection_type["listHandleServiceGroups:::id"]=""
operation_parameters_collection_type["listHandleServiceUsers:::id"]=""
operation_parameters_collection_type["listHandleserviceHandles:::id"]=""
operation_parameters_collection_type["removeHandleService:::id"]=""
operation_parameters_collection_type["removeHandleServiceGroup:::id"]=""
operation_parameters_collection_type["removeHandleServiceGroup:::gid"]=""
operation_parameters_collection_type["removeHandleServiceUser:::id"]=""
operation_parameters_collection_type["removeHandleServiceUser:::uid"]=""
operation_parameters_collection_type["setHandleServiceGroupPrivileges:::id"]=""
operation_parameters_collection_type["setHandleServiceGroupPrivileges:::gid"]=""
operation_parameters_collection_type["setHandleServiceGroupPrivileges:::privileges"]=""
operation_parameters_collection_type["setHandleServiceUserPrivileges:::id"]=""
operation_parameters_collection_type["setHandleServiceUserPrivileges:::uid"]=""
operation_parameters_collection_type["setHandleServiceUserPrivileges:::privileges"]=""
operation_parameters_collection_type["checkMyPorts:::ports"]=
operation_parameters_collection_type["getEffectiveProviderGroup:::pid"]=""
operation_parameters_collection_type["getEffectiveProviderGroup:::gid"]=""
operation_parameters_collection_type["getEffectiveProviderUser:::pid"]=""
operation_parameters_collection_type["getEffectiveProviderUser:::uid"]=""
operation_parameters_collection_type["getProviderDetails:::pid"]=""
operation_parameters_collection_type["getProviderSpace:::pid"]=""
operation_parameters_collection_type["getProviderSpace:::sid"]=""
operation_parameters_collection_type["getSupportedSpace:::sid"]=""
operation_parameters_collection_type["listEffectiveProviderGroups:::pid"]=""
operation_parameters_collection_type["listEffectiveProviderUsers:::pid"]=""
operation_parameters_collection_type["listProviderSpaces:::pid"]=""
operation_parameters_collection_type["mapIdpGroup:::data"]=""
operation_parameters_collection_type["modifyProvider:::data"]=""
operation_parameters_collection_type["modifySupportedSpace:::sid"]=""
operation_parameters_collection_type["providerSpaceSupport:::token"]=""
operation_parameters_collection_type["registerProvider:::data"]=""
operation_parameters_collection_type["removeProvider:::pid"]=""
operation_parameters_collection_type["removeSpaceSupport:::sid"]=""
operation_parameters_collection_type["verifyProviderIdentity:::data"]=""
operation_parameters_collection_type["createShare:::data"]=""
operation_parameters_collection_type["getShare:::id"]=""
operation_parameters_collection_type["modifyShare:::id"]=""
operation_parameters_collection_type["modifyShare:::data"]=""
operation_parameters_collection_type["removeShare:::id"]=""
operation_parameters_collection_type["addGroupToSpace:::id"]=""
operation_parameters_collection_type["addGroupToSpace:::gid"]=""
operation_parameters_collection_type["addGroupToSpace:::privileges"]=""
operation_parameters_collection_type["addUserToSpace:::id"]=""
operation_parameters_collection_type["addUserToSpace:::uid"]=""
operation_parameters_collection_type["addUserToSpace:::privileges"]=""
operation_parameters_collection_type["createSpace:::name"]=""
operation_parameters_collection_type["createSpaceGroupToken:::id"]=""
operation_parameters_collection_type["createSpaceSupportToken:::id"]=""
operation_parameters_collection_type["createSpaceUserInviteToken:::id"]=""
operation_parameters_collection_type["getEffectiveSpaceGroup:::id"]=""
operation_parameters_collection_type["getEffectiveSpaceGroup:::gid"]=""
operation_parameters_collection_type["getEffectiveSpaceUser:::id"]=""
operation_parameters_collection_type["getEffectiveSpaceUser:::uid"]=""
operation_parameters_collection_type["getSpace:::id"]=""
operation_parameters_collection_type["getSpaceGroup:::id"]=""
operation_parameters_collection_type["getSpaceGroup:::gid"]=""
operation_parameters_collection_type["getSpaceProvider:::id"]=""
operation_parameters_collection_type["getSpaceProvider:::pid"]=""
operation_parameters_collection_type["getSpaceShare:::id"]=""
operation_parameters_collection_type["getSpaceShare:::sid"]=""
operation_parameters_collection_type["getSpaceUser:::id"]=""
operation_parameters_collection_type["getSpaceUser:::uid"]=""
operation_parameters_collection_type["listEffectiveSpaceGroupPrivileges:::id"]=""
operation_parameters_collection_type["listEffectiveSpaceGroupPrivileges:::gid"]=""
operation_parameters_collection_type["listEffectiveSpaceGroups:::id"]=""
operation_parameters_collection_type["listEffectiveSpaceUserPrivileges:::id"]=""
operation_parameters_collection_type["listEffectiveSpaceUserPrivileges:::uid"]=""
operation_parameters_collection_type["listEffectiveSpaceUsers:::id"]=""
operation_parameters_collection_type["listSpaceGroupPrivileges:::id"]=""
operation_parameters_collection_type["listSpaceGroupPrivileges:::gid"]=""
operation_parameters_collection_type["listSpaceGroups:::id"]=""
operation_parameters_collection_type["listSpaceProviders:::id"]=""
operation_parameters_collection_type["listSpaceShares:::id"]=""
operation_parameters_collection_type["listSpaceUserPrivileges:::id"]=""
operation_parameters_collection_type["listSpaceUserPrivileges:::uid"]=""
operation_parameters_collection_type["listSpaceUsers:::id"]=""
operation_parameters_collection_type["modifySpace:::id"]=""
operation_parameters_collection_type["modifySpace:::data"]=""
operation_parameters_collection_type["removeProviderSupportingSpace:::id"]=""
operation_parameters_collection_type["removeProviderSupportingSpace:::pid"]=""
operation_parameters_collection_type["removeSpace:::id"]=""
operation_parameters_collection_type["removeSpaceGroup:::id"]=""
operation_parameters_collection_type["removeSpaceGroup:::gid"]=""
operation_parameters_collection_type["removeSpaceUser:::id"]=""
operation_parameters_collection_type["removeSpaceUser:::uid"]=""
operation_parameters_collection_type["setSpaceGroupPrivileges:::id"]=""
operation_parameters_collection_type["setSpaceGroupPrivileges:::gid"]=""
operation_parameters_collection_type["setSpaceGroupPrivileges:::data"]=""
operation_parameters_collection_type["setSpaceUserPrivileges:::id"]=""
operation_parameters_collection_type["setSpaceUserPrivileges:::uid"]=""
operation_parameters_collection_type["setSpaceUserPrivileges:::data"]=""
operation_parameters_collection_type["addUserHandleService:::handleService"]=""
operation_parameters_collection_type["authorizeUser:::data"]=""
operation_parameters_collection_type["createGroupForUser:::group"]=""
operation_parameters_collection_type["createUserHandle:::handle"]=""
operation_parameters_collection_type["createUserSpace:::space"]=""
operation_parameters_collection_type["getEffectiveUserProvider:::pid"]=""
operation_parameters_collection_type["getEffectiveUserSpace:::sid"]=""
operation_parameters_collection_type["getUser:::id"]=""
operation_parameters_collection_type["getUserEffectiveGroup:::gid"]=""
operation_parameters_collection_type["getUserEffectiveHandle:::hid"]=""
operation_parameters_collection_type["getUserEffectiveHandleService:::hsid"]=""
operation_parameters_collection_type["getUserGroup:::gid"]=""
operation_parameters_collection_type["getUserHandle:::hid"]=""
operation_parameters_collection_type["getUserHandleService:::hsid"]=""
operation_parameters_collection_type["getUserSpace:::sid"]=""
operation_parameters_collection_type["getUserSpaceAlias:::sid"]=""
operation_parameters_collection_type["joinGroup:::groupinvitetoken"]=""
operation_parameters_collection_type["joinSpace:::spaceinvitetoken"]=""
operation_parameters_collection_type["leaveGroup:::gid"]=""
operation_parameters_collection_type["listUserOnezoneEffectivePrivileges:::id"]=""
operation_parameters_collection_type["listUserOnezonePrivileges:::id"]=""
operation_parameters_collection_type["modifyCurrentUser:::data"]=""
operation_parameters_collection_type["removeClientToken:::tid"]=""
operation_parameters_collection_type["removeUser:::id"]=""
operation_parameters_collection_type["removeUserHandle:::hid"]=""
operation_parameters_collection_type["removeUserHandleService:::hsid"]=""
operation_parameters_collection_type["removeUserOnezonePrivileges:::id"]=""
operation_parameters_collection_type["removeUserSpace:::sid"]=""
operation_parameters_collection_type["removeUserSpaceAlias:::sid"]=""
operation_parameters_collection_type["setCurrentUserPrivileges:::data"]=""
operation_parameters_collection_type["setDefaultProvider:::defaultprovider"]=""
operation_parameters_collection_type["setDefaultSpace:::defaultspace"]=""
operation_parameters_collection_type["setUserOnezonePrivileges:::id"]=""
operation_parameters_collection_type["setUserOnezonePrivileges:::data"]=""
operation_parameters_collection_type["setUserSpaceAlias:::sid"]=""
operation_parameters_collection_type["setUserSpaceAlias:::data"]=""


##
# Map for body parameters passed after operation as
# PARAMETER==STRING_VALUE or PARAMETER:=NUMERIC_VALUE
# These will be mapped to top level json keys ( { "PARAMETER": "VALUE" })
declare -A body_parameters

##
# These arguments will be directly passed to cURL
curl_arguments="-sS --tlsv1.2"

##
# The host for making the request
host="$ONEZONE_HOST"

##
# The user credentials for basic authentication
basic_auth_credential="$ONEZONE_BASIC_AUTH"

##
# The user API key
apikey_auth_credential="$ONEZONE_API_KEY"

##
# If true, the script will only output the actual cURL command that would be
# used
print_curl=false

##
# The operation ID passed on the command line
operation=""

##
# The provided Accept header value
header_accept=""

##
# The provided Content-type header value
header_content_type=""

##
# If there is any body content on the stdin pass it to the body of the request
body_content_temp_file=""

##
# If this variable is set to true, the request will be performed even
# if parameters for required query, header or body values are not provided
# (path parameters are still required).
force=false

##
# Declare some mime types abbreviations for easier content-type and accepts
# headers specification
declare -A mime_type_abbreviations
# text/*
mime_type_abbreviations["text"]="text/plain"
mime_type_abbreviations["html"]="text/html"
mime_type_abbreviations["md"]="text/x-markdown"
mime_type_abbreviations["csv"]="text/csv"
mime_type_abbreviations["css"]="text/css"
mime_type_abbreviations["rtf"]="text/rtf"
# application/*
mime_type_abbreviations["json"]="application/json"
mime_type_abbreviations["xml"]="application/xml"
mime_type_abbreviations["yaml"]="application/yaml"
mime_type_abbreviations["js"]="application/javascript"
mime_type_abbreviations["bin"]="application/octet-stream"
mime_type_abbreviations["rdf"]="application/rdf+xml"
# image/*
mime_type_abbreviations["jpg"]="image/jpeg"
mime_type_abbreviations["png"]="image/png"
mime_type_abbreviations["gif"]="image/gif"
mime_type_abbreviations["bmp"]="image/bmp"
mime_type_abbreviations["tiff"]="image/tiff"


##############################################################################
#
# Escape special URL characters
# Based on table at http://www.w3schools.com/tags/ref_urlencode.asp
#
##############################################################################
url_escape() {
    local raw_url="$1"

    value=$(sed -e 's/ /%20/g' \
       -e 's/!/%21/g' \
       -e 's/"/%22/g' \
       -e 's/#/%23/g' \
       -e 's/\&/%26/g' \
       -e 's/'\''/%28/g' \
       -e 's/(/%28/g' \
       -e 's/)/%29/g' \
       -e 's/:/%3A/g' \
       -e 's/?/%3F/g' <<<$raw_url);

    echo $value
}

##############################################################################
#
# Lookup the mime type abbreviation in the mime_type_abbreviations array.
# If not present assume the user provided a valid mime type
#
##############################################################################
lookup_mime_type() {
    local mime_type=$1

    if [[ ${mime_type_abbreviations[$mime_type]} ]]; then
        echo ${mime_type_abbreviations[$mime_type]}
    else
        echo $1
    fi
}

##############################################################################
#
# Converts an associative array into a list of cURL header
